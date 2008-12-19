From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rm -n leaves .git/index.lock if not allowed to finish
Date: Thu, 18 Dec 2008 16:38:26 -0800
Message-ID: <7v4p11f18d.fsf@gitster.siamese.dyndns.org>
References: <87prjptfo7.fsf@jidanni.org>
 <20081219002524.GB21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:39:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDTPF-0005Ec-4r
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYLSAie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbYLSAie
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:38:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYLSAid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 19:38:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 87F8288ECE;
	Thu, 18 Dec 2008 19:38:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3CEBC88ECD; Thu,
 18 Dec 2008 19:38:28 -0500 (EST)
In-Reply-To: <20081219002524.GB21154@genesis.frugalware.org> (Miklos Vajna's
 message of "Fri, 19 Dec 2008 01:25:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5CED8DDE-CD65-11DD-8E7A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103521>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Fri, Dec 19, 2008 at 04:02:48AM +0800, jidanni@jidanni.org wrote:
>> Bug: if git-rm -n is not allowed to write all it wants to write, it
>> will leave a .git/index.lock file:
>> # git-rm -n -r . 2>&1|sed q
>> error: '.etckeeper' has changes staged in the index
>> # git-rm -n -r . 2>&1|sed q
>> fatal: unable to create '.git/index.lock': File exists
>
> Can't reproduce:
>
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index b7d46e5..1581691 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -251,4 +251,12 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
>  
>  '
>  
> +test_expect_success 'test from jidanni' '
> +
> +	git reset --hard &&
> +	git rm -n -r . 2>&1|sed q &&
> +	git rm -n -r . 2>&1|sed q
> +
> +'
> +
>  test_done
>
> passes here just fine. Yes, there are multiple files in the repo.

I think you need to have tons of files to cause the pipe buffer to fill up
with the "rm 'frotz'" output, triggering a SIGPIPE to kill the upstream
process of the pipe.

Would this patch help?

 lockfile.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git i/lockfile.c w/lockfile.c
index 6d75608..8589155 100644
--- i/lockfile.c
+++ w/lockfile.c
@@ -140,6 +140,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			signal(SIGHUP, remove_lock_file_on_signal);
 			signal(SIGTERM, remove_lock_file_on_signal);
 			signal(SIGQUIT, remove_lock_file_on_signal);
+			signal(SIGPIPE, remove_lock_file_on_signal);
 			atexit(remove_lock_file);
 		}
 		lk->owner = getpid();
