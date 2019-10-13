Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA411F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 20:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfJMUJe (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 16:09:34 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36477 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfJMUJe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 16:09:34 -0400
X-Originating-IP: 1.186.12.3
Received: from localhost (unknown [1.186.12.3])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id C03061C0003;
        Sun, 13 Oct 2019 20:09:31 +0000 (UTC)
Date:   Mon, 14 Oct 2019 01:39:29 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Harish Karumuthil <harish2704@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
Message-ID: <20191013200929.72giwtxlt6ivitfr@yadavpratyush.com>
References: <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
 <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
 <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
 <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
 <e71835129c0628ff3b9a0653febc3737128fa23c.camel@gmail.com>
 <nycvar.QRO.7.76.6.1910071159530.46@tvgsbejvaqbjf.bet>
 <f751705949a7fd23c77cbbf839c081b95b12394b.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f751705949a7fd23c77cbbf839c081b95b12394b.camel@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/10/19 01:01AM, Harish Karumuthil wrote:
> Hi all, there is an update:
> 
> I added necessary error catching code so that, script will not crash if the
> keybinding code is worng. Instead of crashing it will print error message.
> The final patch will look something like this.

Like I mentioned another reply I wrote just now, this unfortunately is 
not a "proper" patch because it does not contain the subject and commit 
message of your commit. Just the diff is not enough, and needs the 
commit subject and message too.

And even for just "preview" patches, I would still recommend sending a 
proper patch so people can also peek at the commit message too. You can 
pass '-rfc' to `git-format-patch` to have something like '[RFC PATCH]' 
in your email subject so people know it is a preview. "RFC" stands for 
"Request For Comments".

Some comments below.
 
> ---
>  lib/tools.tcl | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/tools.tcl b/lib/tools.tcl
> index 413f1a1700..3135e19131 100644
> --- a/lib/tools.tcl
> +++ b/lib/tools.tcl
> @@ -38,7 +38,7 @@ proc tools_create_item {parent args} {
>  }
>  
>  proc tools_populate_one {fullname} {
> -	global tools_menubar tools_menutbl tools_id
> +	global tools_menubar tools_menutbl tools_id repo_config
>  
>  	if {![info exists tools_id]} {
>  		set tools_id 0
> @@ -61,9 +61,25 @@ proc tools_populate_one {fullname} {
>  		}
>  	}
>  
> -	tools_create_item $parent command \
> -		-label [lindex $names end] \
> -		-command [list tools_exec $fullname]
> +	set accel_key_bound 0
> +	if {[info exists repo_config(guitool.$fullname.gitgui-shortcut)]} {
> +		set accel_key $repo_config(guitool.$fullname.gitgui-shortcut)
> +		if { [ catch { bind . <$accel_key> [list tools_exec $fullname] } msg ] } {

This has inconsistent style. There should not be any spaces between '{' 
and '['. So this line should look something like:

  if {[catch {bind . <$accel_key> [list tools_exec $fullname]} msg]} {

You can look at the code around yours to pick up on the general style. 

> +			puts stderr "Failed to bind keyboard shortcut '$accel_key' for custom tool '$fullname'. Error: $msg"

Putting the error message of a GUI application on stderr is probably not 
a good idea. Firstly, since it is a GUI application, we should show 
error messages in the GUI. And secondly, a lot of the time, people 
probably don't even launch git-gui from a terminal command, and do it 
via some application launcher. In that case, there is no stderr that the 
user can easily read from.

So please use a popup dialog instead. Functions to easily create them 
can be found in lib/error.tcl. I'd recommend either `warn_popup` or 
`error_popup`.

As an example, this is what I got when I added a bad shortcut:

  Failed to bind keyboard shortcut 'Ctrl-Z' for custom tool 'Foo'. Error: bad event type or keysym "Ctrl"

Showing the error message from `bind` is pretty neat! The user can know 
_exactly_ what's wrong. One problem is that this might not make that 
much sense to a non-Tcler. But I still think giving a hint of the why it 
failed is a good idea.

I'd like to hear other people's thoughts about it though.

> +		} else {
> +			tools_create_item $parent command \
> +			-label [lindex $names end] \
> +			-command [list tools_exec $fullname] \
> +			-accelerator $accel_key
> +			set accel_key_bound true

Above you set `accel_key_bound` to '0', and here you set it to 'true'. 
Please use consistent forms of a boolean. Either use 'true' and 'false', 
or use '0' and '1'.

> +		}
> +	}
> +
> +	if { ! $accel_key_bound } {

Same style nitpick about the spaces as above.

> +		tools_create_item $parent command \
> +			-label [lindex $names end] \
> +			-command [list tools_exec $fullname]
> +	}
>  }

Can your whole logic of setting an accelerator in case a shortcut exists 
be simplified a bit? Right now, the tools creation command is executed 
in two places, and it is not obvious at first sight that only one of 
them will ever be executed. So maybe something like:

  ...
  if {[catch {bind . <$accel_key> ...} {
  	puts stderr ...
  	set accel_key_bound false
  } else {
  	set accel_key_bound true
  }
  
  if {accel_key_bound} {
  	# Create tool with accelerator
  	...
  } else {
  	# Create tool without accelerator
  	...
  }

I hope you get what this means, but if you don't, please let me know, 
and I'll clarify.

Overall, I like the idea of the patch. This would move us one step in 
the direction of customizable keybindings for _all_ shortcuts. Thanks.

>  
>  proc tools_exec {fullname} {
> ---
> 
> @Johannes Schindelin: In short, from your previous message I understand point.
> 
> 1. shortcut codes like "<Control-,>" will only in Windows platform. It may not work in Linux / Mac.
> 2. We need do translate shortcut codes somehow ( using one-to-one maping ).
> 
> If this is correct, do you have any example on how to do one-to-one maping of a list of string on TCL ?
 

-- 
Regards,
Pratyush Yadav
