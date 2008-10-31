From: Ian Hilt <ihilt@mcgregor-surmount.com>
Subject: Re: [PATCH 3/3] git send-email: add --annotate option
Date: Fri, 31 Oct 2008 17:34:03 -0400
Message-ID: <20081031213403.GC21345@maintenance05.msc.mcgregor-surmount.com>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225450632-7230-2-git-send-email-madcoder@debian.org> <1225450632-7230-3-git-send-email-madcoder@debian.org> <1225450632-7230-4-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:35:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1eM-0007Kf-7H
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbYJaVeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYJaVeH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:34:07 -0400
Received: from mail.mcgregor-surmount.com ([70.61.40.162]:59200 "EHLO
	mcgregor-surmount.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751643AbYJaVeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:34:06 -0400
Received: from maintenance05.msc.mcgregor-surmount.com ([70.61.40.162]) by mcgregor-surmount.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Oct 2008 17:34:03 -0400
Content-Disposition: inline
In-Reply-To: <1225450632-7230-4-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 31 Oct 2008 21:34:03.0396 (UTC) FILETIME=[651CC440:01C93BA0]
X-TM-AS-Product-Ver: SMEX-8.1.0.1092-5.500.1027-16252.002
X-TM-AS-Result: No--19.275400-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99648>

On Fri, Oct 31, 2008 at 11:57:12AM +0100, Pierre Habouzit wrote:
> This allows to review every patch (and fix various aspects of them, or
> comment them) in an editor just before being sent. Combined to the fact
> that git send-email can now process revision lists, this makes git
> send-email and efficient way to review and send patches interactively.
> 
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  Documentation/git-send-email.txt |   11 +++++++++++
>  git-send-email.perl              |   26 ++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index cafff1a..9ee81d5 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -37,6 +37,11 @@ The --bcc option must be repeated for each user you want on the bcc list.
>  +
>  The --cc option must be repeated for each user you want on the cc list.
>  
> +--annotate::
> +	Review each patch you're about to send in an editor. The setting
> +	'sendemail.multiedit' defines if this will spawn one editor per patch
> +	or one for all of them at once.
> +
>  --compose::
>  	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
>  	introductory message for the patch series.
> @@ -204,6 +209,12 @@ sendemail.aliasfiletype::
>  	Format of the file(s) specified in sendemail.aliasesfile. Must be
>  	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
>  
> +sendemail.multiedit::
> +	If true (default), a single editor instance will be spawned to edit
> +	files you have to edit (patches when '--annotate' is used, and the
> +	summary when '--compose' is used). If false, files will be edited one
> +	after the other, spawning a new editor each time.
> +
>  
>  Author
>  ------
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 0d50ee2..65c254d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -48,6 +48,7 @@ git send-email [options] <file | directory | rev-list >
>      --bcc                   <str>  * Email Bcc:
>      --subject               <str>  * Email "Subject:"
>      --in-reply-to           <str>  * Email "In-Reply-To:"
> +    --annotate                     * Review each patch that will be sent in an editor.
>      --compose                      * Open an editor for introduction.
>  
>    Sending:
> @@ -130,7 +131,8 @@ my $compose_filename = ".msg.$$";
>  
>  # Variables we fill in automatically, or via prompting:
>  my (@to,@cc,@initial_cc,@bcclist,@xh,
> -	$initial_reply_to,$initial_subject,@files,$author,$sender,$smtp_authpass,$compose,$time);
> +	$initial_reply_to,$initial_subject,@files,
> +	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
>  
>  my $envelope_sender;
>  
> @@ -151,6 +153,17 @@ if ($@) {
>  # Behavior modification variables
>  my ($quiet, $dry_run) = (0, 0);
>  
> +# Handle interactive edition of files.

s/edition/editing/;
