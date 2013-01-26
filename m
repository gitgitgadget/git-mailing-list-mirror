From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] mergetools: Simplify how we handle "vim" and "defaults"
Date: Sat, 26 Jan 2013 12:12:02 +0000
Message-ID: <20130126121202.GH7498@serenity.lan>
References: <1359183058-51835-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 13:20:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz4ji-0002NG-Cj
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 13:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab3AZMTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 07:19:34 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:49539 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab3AZMTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 07:19:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9F055CDA606;
	Sat, 26 Jan 2013 12:12:09 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5lyBrzCkMV3m; Sat, 26 Jan 2013 12:12:09 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B4215CDA602;
	Sat, 26 Jan 2013 12:12:04 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1359183058-51835-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214621>

On Fri, Jan 25, 2013 at 10:50:58PM -0800, David Aguilar wrote:
> Remove the exceptions for "vim" and "defaults" in the mergetool library
> so that every filename in mergetools/ matches 1:1 with the name of a
> valid built-in tool.
> 
> Make common functions available in $MERGE_TOOLS_DIR/include/.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> 
> diff --git a/Makefile b/Makefile
> index f69979e..3bc6eb5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2724,7 +2724,7 @@ install: all
>  	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
> -	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
> +	cp -R mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'

Shouldn't this be more like this?

	$(INSTALL) -m 644 $(subst include,,$(wildcard mergetools/*)) \
		'$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'
	$(INSTALL) -m 644 mergetools/include/* \
		'$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'

I'm not sure creating an 'include' directory actually buys us much over
declaring that 'vimdiff' is the real script and the others just source
it.  Either way there is a single special entry in the mergetools
directory.

>  ifndef NO_GETTEXT
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
>  	(cd po/build/locale && $(TAR) cf - .) | \
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index aa38bd1..c866ed8 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -1,5 +1,7 @@
>  #!/bin/sh
>  # git-mergetool--lib is a library for common merge tool functions
> +MERGE_TOOLS_DIR="$(git --exec-path)/mergetools"
> +
>  diff_mode() {
>  	test "$TOOL_MODE" = diff
>  }
> @@ -44,25 +46,14 @@ valid_tool () {
>  }
>  
>  setup_tool () {
> -	case "$1" in
> -	vim*|gvim*)
> -		tool=vim
> -		;;
> -	*)
> -		tool="$1"
> -		;;
> -	esac
> -	mergetools="$(git --exec-path)/mergetools"
> +	tool="$1"

Unnecessary quoting.

> -	# Load the default definitions
> -	. "$mergetools/defaults"
> -	if ! test -f "$mergetools/$tool"
> +	if ! test -f "$MERGE_TOOLS_DIR/$tool"
>  	then
>  		return 1
>  	fi
> -
> -	# Load the redefined functions
> -	. "$mergetools/$tool"
> +	. "$MERGE_TOOLS_DIR/include/defaults.sh"
> +	. "$MERGE_TOOLS_DIR/$tool"
>  
>  	if merge_mode && ! can_merge
>  	then
> @@ -99,7 +90,7 @@ run_merge_tool () {
>  	base_present="$2"
>  	status=0
>  
> -	# Bring tool-specific functions into scope
> +	# Bring tool specific functions into scope

This isn't related to this change (and I think tool-specific is more
correct anyway).

>  	setup_tool "$1"
>  
>  	if merge_mode
> @@ -177,18 +168,17 @@ list_merge_tool_candidates () {
>  show_tool_help () {
>  	unavailable= available= LF='
>  '
> -
> -	scriptlets="$(git --exec-path)"/mergetools
> -	for i in "$scriptlets"/*
> +	for i in "$MERGE_TOOLS_DIR"/*
>  	do
> -		. "$scriptlets"/defaults
> -		. "$i"
> -
> -		tool="$(basename "$i")"
> -		if test "$tool" = "defaults"
> +		if test -d "$i"
>  		then
>  			continue
> -		elif merge_mode && ! can_merge
> +		fi
> +
> +		. "$MERGE_TOOLS_DIR"/include/defaults.sh
> +		. "$i"
> +
> +		if merge_mode && ! can_merge
>  		then
>  			continue
>  		elif diff_mode && ! can_diff
> @@ -196,6 +186,7 @@ show_tool_help () {
>  			continue
>  		fi


I'd prefer to see my change to setup_tool done before this so that we
can just use:

	setup_tool "$tool" 2>/dev/null || continue

for the above block.  I'll send a fixed version in a couple of minutes.

> +		tool=$(basename "$i")
>  		merge_tool_path=$(translate_merge_tool_path "$tool")
>  		if type "$merge_tool_path" >/dev/null 2>&1
>  		then
> diff --git a/mergetools/gvimdiff b/mergetools/gvimdiff
> new file mode 100644
> index 0000000..f5890b1
> --- /dev/null
> +++ b/mergetools/gvimdiff
> @@ -0,0 +1 @@
> +. "$MERGE_TOOLS_DIR/include/vim.sh"
> diff --git a/mergetools/gvimdiff2 b/mergetools/gvimdiff2
> new file mode 100644
> index 0000000..f5890b1
> --- /dev/null
> +++ b/mergetools/gvimdiff2
> @@ -0,0 +1 @@
> +. "$MERGE_TOOLS_DIR/include/vim.sh"
> diff --git a/mergetools/defaults b/mergetools/include/defaults.sh
> similarity index 100%
> rename from mergetools/defaults
> rename to mergetools/include/defaults.sh
> diff --git a/mergetools/vim b/mergetools/include/vim.sh
> similarity index 100%
> rename from mergetools/vim
> rename to mergetools/include/vim.sh
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> new file mode 100644
> index 0000000..f5890b1
> --- /dev/null
> +++ b/mergetools/vimdiff
> @@ -0,0 +1 @@
> +. "$MERGE_TOOLS_DIR/include/vim.sh"
> diff --git a/mergetools/vimdiff2 b/mergetools/vimdiff2
> new file mode 100644
> index 0000000..f5890b1
> --- /dev/null
> +++ b/mergetools/vimdiff2
> @@ -0,0 +1 @@
> +. "$MERGE_TOOLS_DIR/include/vim.sh"
