From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] add pack index v2 reading capability to git v1.4.4.4
Date: Thu, 17 Jul 2008 01:01:20 -0700
Message-ID: <7vzlohhrcf.fsf@gitster.siamese.dyndns.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org>
 <alpine.LFD.1.10.0807160924340.2835@woody.linux-foundation.org>
 <7vhcapsqoa.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807161033170.2835@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 10:02:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJORZ-0007lr-8k
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 10:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100AbYGQIB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 04:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbYGQIB3
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 04:01:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719AbYGQIB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 04:01:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BCEF327006;
	Thu, 17 Jul 2008 04:01:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D145227003; Thu, 17 Jul 2008 04:01:22 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807161033170.2835@woody.linux-foundation.org>
 (Linus Torvalds's message of "Wed, 16 Jul 2008 10:34:13 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E5DF4B6-53D6-11DD-8305-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88814>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 16 Jul 2008, Junio C Hamano wrote:
>> 
>> I do not think it should SEGV.  The pack-idx signature was chosen rather
>> carefully to allow older ones to die gracefully.
>
> Well, Pasky reported differently.
>
>>     error: non-monotonic index
>>     error: Could not read 4a588075c54cd5902e5f4d43b9d6b0c31d0f9769
>
> Pasky's report was
>
> 	error: non-monotonic index
> 	/usr/bin/git-fetch: line 297: 30402 Segmentation fault git-http-fetch -v -a "$head" "$remote/"
>
> but maybe that was something specific to his case.

It is caused by the http walker not being careful.  In v1.4.4.5
http-fetch.c, this code appears unmodified since v1.4.4.4, and an
equivalent code is still in http-walker.c in more recent versions:

    static int setup_index(struct alt_base *repo, unsigned char *sha1)
    {
            struct packed_git *new_pack;
            if (has_pack_file(sha1))
                    return 0; /* don't list this as something we can get */

            if (fetch_index(repo, sha1))
                    return -1;

            new_pack = parse_pack_index(sha1);
            new_pack->next = repo->packs;
            repo->packs = new_pack;
            return 0;
    }

Nico taught parse_pack_index() what v2 pack idx file looks like, but when
the code hits unknown idx file (or a corrupt one), the function signals
error by returning NULL; assigning to new_pack->next without checking
would segfault.

We would need this fix to futureproof ourselves for pack idx v3 and later,
and also for protecting from a corrupt idx file coming over the wire.

---

 http-walker.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 51c18f2..9dc6b27 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -442,6 +442,8 @@ static int setup_index(struct walker *walker, struct alt_base *repo, unsigned ch
 		return -1;
 
 	new_pack = parse_pack_index(sha1);
+	if (!new_pack)
+		return -1; /* parse_pack_index() already issued an error message */
 	new_pack->next = repo->packs;
 	repo->packs = new_pack;
 	return 0;
