From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/2] commit: allow editing notes in commit message editor
Date: Tue, 08 Mar 2011 10:15:24 +0100
Message-ID: <201103081015.24474.johan@herland.net>
References: <20110307233902.GA20447@sigill.intra.peff.net>
 <20110307234138.GB20912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 10:15:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwt0w-0000vF-58
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 10:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab1CHJP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 04:15:28 -0500
Received: from smtp.getmail.no ([84.208.15.66]:42693 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726Ab1CHJP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 04:15:26 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LHQ004F8F1PCNB0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Mar 2011 10:15:25 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5A71A1EA592E_D75F3ADB	for <git@vger.kernel.org>; Tue,
 08 Mar 2011 09:15:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 20E5A1EA3274_D75F3ADF	for <git@vger.kernel.org>; Tue,
 08 Mar 2011 09:15:25 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LHQ003J1F1PGK00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Mar 2011 10:15:25 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <20110307234138.GB20912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168648>

On Tuesday 08 March 2011, Jeff King wrote:
> Changes from v1:
> 
>   - fix bug with adding notes to new commit (we failed to
>     initialize the notes tree properly in this case)
> 
>   - you can now do "commit --notes=foo" to view/edit
>     refs/notes/foo

Nice. :)

>   - added tests for basic operations, plus interaction with
>     --cleanup and -v
> 
>   - turn off commit rewriting when we edit
> 
> Todo:
> 
>   - commit.notes config variable to have this on all the time
> 
>   - I punted on the separator decision here.

We probably want to make it configurable, as mentioned earlier in the 
thread. Still, making it configurable gives me the somewhat uneasy feeling 
that we're "blaming" the user for any false positives ("It's your fault for 
not choosing a more unique separator...")...

What if we start the separator with a comment character (e.g. "# ---"). That 
way, the user could not expect a false positive to make it into the commit 
message in the first place (since it'd be stripped along with other 
comments). Of course, we'd have to make sure that the notes separator was 
parsed before removing the comments, but I think that's already taken care 
of in the patch below.

>   - probably still some magic needed for rebase conflict
>     case; we will be making a new commit, so we don't know
>     to pull the notes in from the old commit as we do with
>     --amend.

Maybe add a "--notes-copy=<commit>" argument to "git commit" that causes 
"<commit>" to be passed to add_notes_from_commit(). Of course, in the case 
of --amend, the default is "--notes-copy=HEAD".

>   - still needs the format-patch component to make the
>     workflow complete :)
> 
>  builtin/commit.c        |   87 ++++++++++++++++++++++-
>  t/t7510-commit-notes.sh |  183 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 268 insertions(+), 2 deletions(-)
>  create mode 100755 t/t7510-commit-notes.sh
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index d71e1e0..f84ca23 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c

[...]

> @@ -559,6 +564,68 @@ static char *cut_ident_timestamp_part(char *string)
>  	return ket;
>  }
> 
> +static void init_edit_notes() {

style nit: move "{" to next line.

[...]

> +static void update_notes_for_commit(struct strbuf *notes,
> +				    unsigned char *commit_sha1)
> +{
> +	init_edit_notes();
> +
> +	if (cleanup_mode != CLEANUP_NONE)
> +		stripspace(notes, cleanup_mode == CLEANUP_ALL);
> +
> +	if (!notes->len)
> +		remove_note(&edit_notes_tree, commit_sha1);
> +	else {
> +		unsigned char blob_sha1[20];
> +		if (write_sha1_file(notes->buf, notes->len,
> +				    blob_type, blob_sha1) < 0)
> +			die("unable to write note blob");
> +		add_note(&edit_notes_tree, commit_sha1, blob_sha1,
> +			 combine_notes_overwrite);

We may want to consider adding a small convenience function to the notes API 
for turning a strbuf into a notes blob. (Maybe s/strbuf/char* + len/ to 
cater for binary notes blobs as well.) This would move some low-level 
details (#include "blob.h", and write_sha1_file(...)) out of the notes API 
users' code.


Otherwise, this looks really good.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
