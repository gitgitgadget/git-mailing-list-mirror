From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-recursive: respect core.autocrlf
Date: Mon, 09 Jun 2008 14:36:29 -0700
Message-ID: <7vod6affz6.fsf@gitster.siamese.dyndns.org>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org>
 <484D3225.3020900@viscovery.net> <alpine.DEB.1.00.0806092221420.1783@racer>
 <alpine.DEB.1.00.0806092223010.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Marius Storm-Olsen <marius@trolltech.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 23:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5p3n-0008QN-Dn
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 23:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488AbYFIVgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbYFIVgq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 17:36:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYFIVgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 17:36:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C7883AFC;
	Mon,  9 Jun 2008 17:36:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 65B413AF6; Mon,  9 Jun 2008 17:36:39 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806092223010.1783@racer> (Johannes
 Schindelin's message of "Mon, 9 Jun 2008 22:23:16 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27CB2426-366C-11DD-B1D4-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84435>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin-merge-recursive.c |    8 ++++++++
>  t/t6033-merge-crlf.sh     |    2 +-
>  2 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
> index 7643f17..edd023f 100644
> --- a/builtin-merge-recursive.c
> +++ b/builtin-merge-recursive.c
> @@ -525,6 +525,7 @@ static void update_file_flags(const unsigned char *sha,
>  		enum object_type type;
>  		void *buf;
>  		unsigned long size;
> +		struct strbuf strbuf;
>  
>  		if (S_ISGITLINK(mode))
>  			die("cannot read object %s '%s': It is a submodule!",
> @@ -535,6 +536,12 @@ static void update_file_flags(const unsigned char *sha,
>  			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
>  		if (type != OBJ_BLOB)
>  			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
> +		strbuf_init(&strbuf, 0);
> +		if (convert_to_working_tree(path, buf, size, &strbuf)) {
> +			free(buf);
> +			size = strbuf.len;
> +			buf = strbuf_detach(&strbuf, NULL);
> +		}
>  
>  		if (make_room_for_path(path) < 0) {
>  			update_wd = 0;

Fairly straightforward fix, except that I suspect this needs to be done
only for regular files and not symlinks.

I think entry.c:write_entry() shows how this should be done.
