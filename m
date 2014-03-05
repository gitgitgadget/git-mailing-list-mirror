From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] git-gui: Add a 'recursive' checkbox in the clone
 menu.
Date: Wed, 05 Mar 2014 19:00:12 +0100
Message-ID: <5317662C.6010404@web.de>
References: <1393974076.7891.27.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Henri GEIST <geist.henri@laposte.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 19:00:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLG7N-0007MH-EV
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 19:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbaCESA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 13:00:29 -0500
Received: from mout.web.de ([212.227.15.3]:59771 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865AbaCESA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 13:00:28 -0500
Received: from [192.168.178.41] ([84.132.147.244]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MJlCO-1WK9eW224K-0018L5; Wed, 05 Mar 2014 19:00:16
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1393974076.7891.27.camel@Naugrim>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ONEG3ScWHgbBjuPDllCNXhQXCHUZKnlINhwX9BsMETM2IjfPS8O
 Dy7z0O0wYdn+hcPrURlEfl+Z5iQXIlzfyrMkmcqJLwaXrq9PAou8bNiQHhNMC45nAl0ILo1
 utbocAri+AhR0deQOfJe449NOp8VswTVKwa72NYKk6r9lVn2fPa4MYgRI+2oJqvOIAahQ13
 2iu0wWfWzYouA8BdX3JEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243454>

Am 05.03.2014 00:01, schrieb Henri GEIST:
> Permit to do a 'git clone --recursive' through git-gui.

I really like where this is heading!

Some minor issues:

- I think we should be more verbose in the commit message,
  including that and why the default should be "on". Maybe
  like this?

  "Permit to do a 'git clone --recursive' through git-gui.
  Add a 'recursive' checkbox in the clone menu which allows
  users to clone a repository and all its submodules in one
  go (unless the 'update' flag is set to "none" in the
  .gitmodules file for a submodule, in that case that
  specific submodule is not cloned automatically).

  Enable this new option per default, as most users want to
  clone all submodules too when cloning the superproject
  (This is currently not possible without leaving git gui
  or adding a custom tool entry for that)."


- I'd rather change the button text from "Recursive (For
  submodules)" to something like "Recursively clone
  submodules too" or such.


- Wouldn't it be easier to pass the '--recurse-submodules"
  option to the "git clone" call for the superproject instead
  of adding the _do_clone_submodules() function doing a
  subsequent "git submodule update --init --recursive"? That
  is also be more future proof with respect to the autoclone
  config option we have in mind (which would add that behavior
  for "git clone" itself, making the call you added redundant).


> Signed-off-by: Henri GEIST <geist.henri@laposte.net>
> ---
> I have set the default checkbox state to 'true' by default has all my gui users
> use it all the time this way.
> But as it change the default behavior you may prefer to set it to 'false' by
> default.
> 
>  git-gui/lib/choose_repository.tcl |   34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
> index 3c10bc6..47d436b 100644
> --- a/git-gui/lib/choose_repository.tcl
> +++ b/git-gui/lib/choose_repository.tcl
> @@ -18,6 +18,7 @@ field local_path       {} ; # Where this repository is locally
>  field origin_url       {} ; # Where we are cloning from
>  field origin_name  origin ; # What we shall call 'origin'
>  field clone_type hardlink ; # Type of clone to construct
> +field recursive      true ; # Recursive cloning flag
>  field readtree_err        ; # Error output from read-tree (if any)
>  field sorted_recent       ; # recent repositories (sorted)
>  
> @@ -525,6 +526,11 @@ method _do_clone {} {
>  	foreach r $w_types {
>  		pack $r -anchor w
>  	}
> +	${NS}::checkbutton $args.type_f.recursive \
> +		-text [mc "Recursive (For submodules)"] \
> +		-variable @recursive \
> +		-onvalue true -offvalue false
> +	pack $args.type_f.recursive
>  	grid $args.type_l $args.type_f -sticky new
>  
>  	grid columnconfigure $args 1 -weight 1
> @@ -952,6 +958,30 @@ method _do_clone_checkout {HEAD} {
>  	fileevent $fd readable [cb _readtree_wait $fd]
>  }
>  
> +method _do_validate_submodule_cloning {ok} {
> +	if {$ok} {
> +		$o_cons done $ok
> +		set done 1
> +	} else {
> +		_clone_failed $this [mc "Cannot clone submodules."]
> +	}
> +}
> +
> +method _do_clone_submodules {} {
> +	if {$recursive eq {true}} {
> +		destroy $w_body
> +		set o_cons [console::embed \
> +			$w_body \
> +			[mc "Cloning submodules"]]
> +		pack $w_body -fill both -expand 1 -padx 10
> +		$o_cons exec \
> +			[list git submodule update --init --recursive] \
> +			[cb _do_validate_submodule_cloning]
> +	} else {
> +		set done 1
> +	}
> +}
> +
>  method _readtree_wait {fd} {
>  	set buf [read $fd]
>  	$o_cons update_meter $buf
> @@ -982,7 +1012,7 @@ method _readtree_wait {fd} {
>  		fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
>  		fileevent $fd_ph readable [cb _postcheckout_wait $fd_ph]
>  	} else {
> -		set done 1
> +		_do_clone_submodules $this
>  	}
>  }
>  
> @@ -996,7 +1026,7 @@ method _postcheckout_wait {fd_ph} {
>  			hook_failed_popup post-checkout $pch_error 0
>  		}
>  		unset pch_error
> -		set done 1
> +		_do_clone_submodules $this
>  		return
>  	}
>  	fconfigure $fd_ph -blocking 0
> 
