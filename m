From: Johan Herland <johan@herland.net>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Thu, 26 Mar 2009 09:29:58 +0100
Message-ID: <200903260929.58321.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <200903260122.24770.johan@herland.net>
 <7vprg4rbmp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 09:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lml01-0001dA-K0
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 09:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZCZIaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 04:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755086AbZCZIaK
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 04:30:10 -0400
Received: from mx.getmail.no ([84.208.15.66]:55977 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755010AbZCZIaF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 04:30:05 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300MMXU9ZL610@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 26 Mar 2009 09:29:59 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300AJ9U9YZJ40@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 26 Mar 2009 09:29:59 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.26.81641
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <7vprg4rbmp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114750>

On Thursday 26 March 2009, Junio C Hamano wrote:
> To fix the loose object codepath, the earlier patch added a call to
> adjust_shared_perm() to write_loose_object() function, but after looking
> at your 7th patch, I realized that the pattern of file creation inside
> $GIT_DIR typically is to first create a temporary file, write to it, and
> then finish it off by calling move_temp_to_file().  The true purpose of
> the function is to "finalize the file being created", and it is misnamed
> in that it describes how its implementation does it currently (i.e. by
> renaming the temporary file to its final name), but it makes perfect
> sense to call adjust_shared_perm() inside it as a part of finalization. 
> I think this should cover the codepaths your 7th patch fixed without
> actually touching them.

Yes, with one exception:

For the two cases index-pack.c, the chmod(foo, 0444) happens AFTER the
corresponding call to move_temp_to_file(xyzzy, foo). The chmod() in
adjust_shared_perms() would thus be overridden by the chmod(foo, 0444),
which is not what we want. In both cases, I think the chmod(foo, 0444)
can safely be moved up above the call to move_temp_to_file(). Something
like this (although I'm not sure about the semantics of 'from_stdin'):

diff --git a/index-pack.c b/index-pack.c
index 7546822..d289b6a 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -815,6 +815,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		}
 	}
 
+	if (from_stdin)
+		chmod(final_pack_name, 0444);
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name) {
 			snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
@@ -824,9 +826,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		if (move_temp_to_file(curr_pack_name, final_pack_name))
 			die("cannot store pack file");
 	}
-	if (from_stdin)
-		chmod(final_pack_name, 0444);
 
+	chmod(final_index_name, 0444);
 	if (final_index_name != curr_index_name) {
 		if (!final_index_name) {
 			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
@@ -836,7 +837,6 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		if (move_temp_to_file(curr_index_name, final_index_name))
 			die("cannot store index file");
 	}
-	chmod(final_index_name, 0444);
 
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(sha1));


> Could you eyeball and re-test it?

> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Tested-by: Johan Herland <johan@herland.net>

> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -195,6 +195,8 @@ static int create_default_files(const char
> *template_path)
>
>  	git_config(git_default_config, NULL);
>  	is_bare_repository_cfg = init_is_bare_repository;
> +
> +	/* reading existing config may have overwrote it */

s/overwrote/overwritten/

Otherwise OK, AFAICS.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
