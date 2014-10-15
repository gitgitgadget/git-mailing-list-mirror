From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is
 only temporary
Date: Wed, 15 Oct 2014 10:34:34 -0400
Message-ID: <543E85FA.6050404@xiplink.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 16:42:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XePmS-0001kP-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 16:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbaJOOmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 10:42:09 -0400
Received: from smtp98.ord1c.emailsrvr.com ([108.166.43.98]:40139 "EHLO
	smtp98.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbaJOOmG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 10:42:06 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2014 10:42:06 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp21.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id F3E13380329;
	Wed, 15 Oct 2014 10:34:32 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp21.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id AF123380207;
	Wed, 15 Oct 2014 10:34:32 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.13);
	Wed, 15 Oct 2014 14:34:32 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-10-14 03:57 PM, Junio C Hamano wrote:
> While use of the --reference option to borrow objects from an
> existing local repository of the same project is an effective way to
> reduce traffic when cloning a project over the network, it makes the
> resulting "borrowing" repository dependent on the "borrowed"
> repository.  After running
> 
> 	git clone --reference=P $URL Q
> 
> the resulting repository Q will be broken if the borrowed repository
> P disappears.
> 
> The way to allow the borrowed repository to be removed is to repack
> the borrowing repository (i.e. run "git repack -a -d" in Q); while
> power users may know it very well, it is not easily discoverable.
> 
> Teach a new "--dissociate" option to "git clone" to run this
> repacking for the user.

After reading the above I thought the option would be better named
"--derference".  It seemed to me to be something one would like to run after
the first --reference clone.

Looking more closely I see that's not the case.  In fact, the option only
makes sense if --reference is also used.

I think things would be more understandable if the option was "--dissociate
<repository>" and was an explicit alternative to --reference:
	[[--reference | --dissociate] <repository>]

I'm still not liking the name "--dissociate" though.  The original suggestion
of "--borrow" is better.  Perhaps "--library" or "--local-cache"?  I dunno...

So now I'm wondering if the implementation would be more efficient as an
extension of the --local operation.  That is, instead of a post-clone repack,
do a --local clone first followed by a simple "git fetch" from the source repo.

		M.


> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This comes from
>    http://thread.gmane.org/gmane.comp.version-control.git/243918/focus=245397
>    which is one of the low-hanging entries in the leftover-bits list
>    http://git-blame.blogspot.com/p/leftover-bits.html
> 
>    Yes, I must have been really bored to do this ;-)
> 
>  Documentation/git-clone.txt | 11 +++++++++--
>  builtin/clone.c             | 25 +++++++++++++++++++++++++
>  t/t5700-clone-reference.sh  | 17 +++++++++++++++++
>  3 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 0363d00..f1f2a3f 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git clone' [--template=<template_directory>]
>  	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
>  	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
> -	  [--separate-git-dir <git dir>]
> +	  [--dissociate] [--separate-git-dir <git dir>]
>  	  [--depth <depth>] [--[no-]single-branch]
>  	  [--recursive | --recurse-submodules] [--] <repository>
>  	  [<directory>]
> @@ -98,7 +98,14 @@ objects from the source repository into a pack in the cloned repository.
>  	require fewer objects to be copied from the repository
>  	being cloned, reducing network and local storage costs.
>  +
> -*NOTE*: see the NOTE for the `--shared` option.
> +*NOTE*: see the NOTE for the `--shared` option, and also the
> +`--dissociate` option.
> +
> +--dissociate::
> +	Borrow the objects from reference repositories specified
> +	with the `--reference` options only to reduce network
> +	transfer and stop borrowing from them after a clone is made
> +	by making necessary local copies of borrowed objects.
>  
>  --quiet::
>  -q::
> diff --git a/builtin/clone.c b/builtin/clone.c
> index bbd169c..780fbd5 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -48,6 +48,7 @@ static int option_verbosity;
>  static int option_progress = -1;
>  static struct string_list option_config;
>  static struct string_list option_reference;
> +static int option_dissociate;
>  
>  static int opt_parse_reference(const struct option *opt, const char *arg, int unset)
>  {
> @@ -93,6 +94,8 @@ static struct option builtin_clone_options[] = {
>  		    N_("create a shallow clone of that depth")),
>  	OPT_BOOL(0, "single-branch", &option_single_branch,
>  		    N_("clone only one branch, HEAD or --branch")),
> +	OPT_BOOL(0, "dissociate", &option_dissociate,
> +		 N_("use --reference only while cloning")),
>  	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
>  		   N_("separate git dir from working tree")),
>  	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
> @@ -736,6 +739,21 @@ static void write_refspec_config(const char* src_ref_prefix,
>  	strbuf_release(&value);
>  }
>  
> +static void dissociate_from_references(void)
> +{
> +	struct child_process cmd;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	argv_array_pushl(&cmd.args, "repack", "-a", "-d", NULL);
> +	cmd.git_cmd = 1;
> +	cmd.out = -1;
> +	cmd.no_stdin = 1;
> +	if (run_command(&cmd))
> +		die(_("cannot repack to clean up"));
> +	if (unlink(git_path("objects/info/alternates")) && errno != ENOENT)
> +		die_errno(_("cannot unlink temporary alternates file"));
> +}
> +
>  int cmd_clone(int argc, const char **argv, const char *prefix)
>  {
>  	int is_bundle = 0, is_local;
> @@ -883,6 +901,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	if (option_reference.nr)
>  		setup_reference();
> +	else if (option_dissociate) {
> +		warning(_("--dissociate given, but there is no --reference"));
> +		option_dissociate = 0;
> +	}
>  
>  	fetch_pattern = value.buf;
>  	refspec = parse_fetch_refspec(1, &fetch_pattern);
> @@ -996,6 +1018,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	transport_unlock_pack(transport);
>  	transport_disconnect(transport);
>  
> +	if (option_dissociate)
> +		dissociate_from_references();
> +
>  	junk_mode = JUNK_LEAVE_REPO;
>  	err = checkout();
>  
> diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
> index 6537911..3e783fc 100755
> --- a/t/t5700-clone-reference.sh
> +++ b/t/t5700-clone-reference.sh
> @@ -198,4 +198,21 @@ test_expect_success 'clone using repo pointed at by gitfile as reference' '
>  	test_cmp expected "$base_dir/O/.git/objects/info/alternates"
>  '
>  
> +test_expect_success 'clone and dissociate from reference' '
> +	git init P &&
> +	(
> +		cd P &&	test_commit one
> +	) &&
> +	git clone P Q &&
> +	(
> +		cd Q && test_commit two
> +	) &&
> +	git clone --no-local --reference=P Q R &&
> +	git clone --no-local --reference=P --dissociate Q S &&
> +	# removing the reference P would corrupt R but not S
> +	rm -fr P &&
> +	test_must_fail git -C R fsck &&
> +	git -C S fsck
> +'
> +
>  test_done
> 
