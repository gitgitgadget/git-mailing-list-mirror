From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4 2/2] gitk: synchronize config write
Date: Mon, 2 Mar 2015 11:10:51 +1100
Message-ID: <20150302001050.GC24862@iris.ozlabs.ibm.com>
References: <1415571602-5858-1-git-send-email-max@max630.net>
 <1415571602-5858-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 01:33:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSEIu-0007Ay-IB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 01:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbbCBAdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 19:33:44 -0500
Received: from ozlabs.org ([103.22.144.67]:56651 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbbCBAdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 19:33:42 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0E03B1400A0; Mon,  2 Mar 2015 11:33:40 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1415571602-5858-3-git-send-email-max@max630.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264569>

On Mon, Nov 10, 2014 at 12:20:02AM +0200, Max Kirillov wrote:
> If several gitk instances are closed simultaneously, safestuff procedure
> can run at the same time, resulting in a conflict which may cause losing
> of some of the instance's changes, failing the saving operation or even
> corrupting the configuration file. This can happen, for example, at user
> session closing, or at group closing of all instances of an application
> which is possible in some desktop environments.
> 
> To avoid this, make sure that only one saving operation is in progress.
> It is guarded by existance of $config_file_tmp file. Both creating the
> file and moving it to $config_file are atomic operations, so it should
> be reliable.
> 
> Reading does not need to be syncronized, because moving is atomic
> operation, and the $config_file always refers to full and correct file.
> But, if there is a stale $config_file_tmp file, report it at gitk start.
> If such file is detected at saving, just abort the saving, because this
> is how gitk used to handle errors while saving.
> 
> Signed-off-by: Max Kirillov <max@max630.net>

The idea looks good; I have a couple of comments on the patch.  First,
50 tries over 5 seconds seems a bit excessive to me, wouldn't (say) 20
tries be enough?  Is the 50 the result of some analysis?

> +	    error_popup "Probably there is stale $config_file_tmp file; config saving is going to fail. Check if it is being used by any existing gitk process and remove it otherwise"

I would word this as "There appears to be a stale $config_file_tmp
file, which will prevent gitk from saving its configuration on exit.
Please remove it if it is not being used by any existing gitk
process."

> @@ -2811,11 +2824,16 @@ proc savestuff {w} {
>  
>      if {$stuffsaved} return
>      if {![winfo viewable .]} return
> +    set remove_tmp 0
>      catch {
> -	if {[file exists $config_file_tmp]} {
> -	    file delete -force $config_file_tmp
> +	set try_count 0
> +	while {[catch {set f [open $config_file_tmp {WRONLY CREAT EXCL}]}]} {
> +	    if {[incr try_count] > 50} {
> +		error "Unable to write config file: $config_file_tmp exists"
> +	    }
> +	    after 100
>  	}
> -	set f [open $config_file_tmp w]
> +	set remove_tmp 1
>  	if {$::tcl_platform(platform) eq {windows}} {
>  	    file attributes $config_file_tmp -hidden true
>  	}
> @@ -2878,6 +2896,14 @@ proc savestuff {w} {
>  	puts $f "}"
>  	close $f
>  	file rename -force $config_file_tmp $config_file
> +	set remove_tmp 0
> +	return ""
> +    } err
> +    if {$err ne ""} {
> +	puts "Error saving config: $err"

I would suggest checking the return from the catch statement, like
this:

	if {[catch {
	    ...
	    file rename -force $config_file_tmp $config_file
	} err]} {
	    puts "Error saving config: $err"
	    if {$remove_tmp} {
		file delete -force $config_file_tmp
	    }
	}

rather than doing a return inside the catch.

Paul.
