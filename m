Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D814270EBC
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415934; cv=none; b=I0tl2QXvYke8BZBxHEqFr7PxMXWMtuXyXzrBJ/3gnOLx3PcKOSaove2xG36HKgkaiqHcXvj6jw4PP6C9/cC/VgSbH0a5SOOfzT9jaN1DZxGU5s8l0vU6Awd6t9Wl3Ptrs2hp/IXAeSZO9tOZRjRaCaZnsxlIEeIGgoEIL1ts0HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415934; c=relaxed/simple;
	bh=g9O0+Tq/bPq+TA4QKDollEb1/3CWIDqTG6eNUZHixJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PInXsCP3xSN0YHQM9FF7xcQfdiIiX90cPpkUg6VKPQNijS1/cp/vrHihQMH3QNDxpqIQXAfTxsUCTpGJ/3scp0eimcAdQLlEfGcrQ33bhiOIeRT03w4xcU9h0jaTmhLLwFzt1IJ+GJW/czAZnynwMm74Y1BkfB9rTfXIzsCJeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4cCZ5H64G2zRnmF;
	Thu, 28 Aug 2025 23:18:43 +0200 (CEST)
Message-ID: <d89cf43f-78c7-46df-878e-b12044c4aa5c@kdbg.org>
Date: Thu, 28 Aug 2025 23:18:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: use tk_messageBox for ask yes/no
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org, me@yadavpratyush.com, johannes.schindelin@gmx.de
References: <4b04832c0b8119b784806f54a2354d910965a523.1756371530.git.gitgitgadget@gmail.com>
 <20250828133301.74328-1-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250828133301.74328-1-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.08.25 um 15:33 schrieb Mark Levedahl:
> git-gui includes git-gui--yesno that relies upon Tk 8.5 constructs, and

/--yesno/--askyesno/? BTW, I wonder which constructs you mean.

> this dialog box is not supported with Tk 9.0.  Tk provides tk_messagebox
> for this same purpose, fully supported in Tk 8.5+, so use tk_messagebox
> instead.

Which "this dialog box" do you mean here? The old code looks like a
usual Tk main window to me.

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui--askyesno | 35 +++++++----------------------------
>  1 file changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/git-gui--askyesno b/git-gui--askyesno
> index 142d1bc..cd986f2 100755
> --- a/git-gui--askyesno
> +++ b/git-gui--askyesno
> @@ -10,12 +10,6 @@ exec wish "$0" -- "$@"
>  # overridden via the optional `--title` command-line
>  # option.
>  
> -set NS {}
> -set use_ttk [package vsatisfies [package provide Tk] 8.5]
> -if {$use_ttk} {
> -	set NS ttk
> -}
> -
>  set title "Question?"
>  if {$argc < 1} {
>  	puts stderr "Usage: $argv0 <question>"
> @@ -28,25 +22,7 @@ if {$argc < 1} {
>  	set prompt [join $argv " "]
>  }
>  
> -${NS}::frame .t
> -${NS}::label .t.m -text $prompt -justify center -width 40
> -.t.m configure -wraplength 400
> -pack .t.m -side top -fill x -padx 20 -pady 20 -expand 1
> -pack .t -side top -fill x -ipadx 20 -ipady 20 -expand 1
> -
> -${NS}::frame .b
> -${NS}::frame .b.left -width 200
> -${NS}::button .b.yes -text Yes -command {exit 0}
> -${NS}::button .b.no  -text No  -command {exit 1}
> -
> -pack .b.left -side left -expand 1 -fill x
> -pack .b.yes -side left -expand 1
> -pack .b.no -side right -expand 1 -ipadx 5
> -pack .b -side bottom -fill x -ipadx 20 -ipady 15
> -
> -bind . <Key-Return> {exit 0}
> -bind . <Key-Escape> {exit 1}
> -
> +set dlgicon {question}
>  if {$::tcl_platform(platform) eq {windows}} {
>  	set icopath [file dirname [file normalize $argv0]]
>  	if {[file tail $icopath] eq {git-core}} {
> @@ -55,9 +31,12 @@ if {$::tcl_platform(platform) eq {windows}} {
>  	set icopath [file dirname $icopath]
>  	set icopath [file join $icopath share git git-for-windows.ico]
>  	if {[file exists $icopath]} {
> -		wm iconbitmap . -default $icopath
> +		set dlgicon $icopath
>  	}
>  }

I think there is a misunderstanding what the purpose of this icon is. It
is the icon shown on the window frame/decoration, not the icon next to
the text.

>  
> -wm title . $title
> -tk::PlaceWindow .
> +wm withdraw .
> +
> +option add *Dialog.msg.font {Sans 10}

Is this to replicate the old appearance? I don't think it is necessary.
Let's assume tk_messageBox does a sensible thing.

> +set ans [tk_messageBox -icon $dlgicon -message $prompt -title $title -type yesno]

This option -icon can only be one of the words error, info, question or
warning. It has nothing to do with the icon above.

> +exit [expr $ans eq {no}]

-- Hannes

