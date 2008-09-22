From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from
 git-gui.
Date: Mon, 22 Sep 2008 09:25:43 +0200
Message-ID: <48D74877.9050607@viscovery.net>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <bb6f213e0809190538m5bbfeb38o5510d06fa6757dd1@mail.gmail.com> <48D3A376.30905@viscovery.net> <200809212252.35769.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 09:26:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khfov-0007JH-IW
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 09:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbYIVHZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 03:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbYIVHZt
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 03:25:49 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28315 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYIVHZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 03:25:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Khfni-0001vG-B7; Mon, 22 Sep 2008 09:25:42 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 15CE26EF; Mon, 22 Sep 2008 09:25:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200809212252.35769.angavrilov@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96451>

Alexander Gavrilov schrieb:
> Subject: [PATCH] gitk: Implement batch lookup and caching of encoding attrs.
> 
> When the diff contains thousands of files, calling git-check-attr
> once per file is very slow. With this patch gitk does attribute
> lookup in batches of 30 files while reading the diff file list,
> which leads to a very noticeable speedup.

This one does not work for me: The correct is not picked up anymore,
neither in Patch mode nor Tree mode. (It works as expected without this
patch.)

> +proc cache_gitattr {attr pathlist} {
> +	global path_attr_cache
> +	set newlist {}
> +	foreach path $pathlist {
> +		if {[info exists path_attr_cache($attr,$path)]} continue
> +		lappend newlist $path
> +	}
> +	while {$newlist ne {}} {
> +		set head [lrange $newlist 0 29]
> +		set newlist [lrange $newlist 30 end]
> +		if {![catch {set rlist [eval exec git check-attr $attr -- $head]}]} {
> +			foreach row [split $rlist "\n"] {
> +				set cols [split $row :]

This colon made me nervous (because of the drive-colon combination on
Windows), but as long as you feed relative paths into 'git check-attr',
this should not matter (in my case).

> +				set path [lindex $cols 0]
> +				set value [join [lrange $cols 2 end] :]
> +				if {[string index $path 0] eq "\""} {
> +					set path [encoding convertfrom [lindex $path 0]]
> +				}
> +				set path_attr_cache($attr,$path) $value
> +			}
> +		}
> +		update
> +	}
> +}
