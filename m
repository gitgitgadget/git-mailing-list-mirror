From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/4] Consistently use the term "builtin" instead of
 "internal command"
Date: Thu, 2 Jan 2014 12:31:32 -0800
Message-ID: <20140102203132.GQ20443@google.com>
References: <52C58FD7.6010608@gmail.com>
 <52C590B0.1020702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:31:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyovd-0000Br-4R
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbaABUbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:31:37 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:53767 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaABUbg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:31:36 -0500
Received: by mail-qc0-f177.google.com with SMTP id m20so13906217qcx.36
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 12:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0A2Czfkk1+EJ++5MvD3xZfy8etgT9gWuwv0fuKCrwFg=;
        b=ffOPlmR+yjP6RWZNY+k39Z8+GTjK1kBr7s7cCZnDyQEaXYAjkXLrL4Zx9+jXMNHz5m
         KMblW2t2d7AHXZLn9apPooyFv3I3ehZW0uIhZ9jVIAwEbPm/qdeqQuqLnXG/KvJ9Lv83
         1my8zZZWxmzZrbsGa/SkkKYmB7MGTVdqX13k3Zt0e07+mv9bvtjQURdLqpgK7urbDwTk
         O1NuwrsNZzuR6PEiwH/jl3gKL1OZ0UM83KVg8NIBWwzGqhu/XbOHhOqx3iYXMvCmwlS+
         GMCAaE6o7UnwmRQSLd+b5MTaPXobkJcG6+39cU/nOzlhVDdL7+QTK3fs1m1O533TvZRP
         ZxBQ==
X-Received: by 10.224.115.137 with SMTP id i9mr101514317qaq.37.1388694695828;
        Thu, 02 Jan 2014 12:31:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id a5sm82148440qae.2.2014.01.02.12.31.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 12:31:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52C590B0.1020702@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239872>

Hi,

Sebastian Schuberth wrote:

[...]
> --- a/Documentation/technical/api-builtin.txt
> +++ b/Documentation/technical/api-builtin.txt
> @@ -14,7 +14,7 @@ Git:
>  
>  . Add the external declaration for the function to `builtin.h`.
>  
> -. Add the command to `commands[]` table in `handle_internal_command()`,
> +. Add the command to `commands[]` table in `handle_builtin()`,

Makes sense.  Using consistent jargon makes for easier reading.

[...]
> +++ b/git.c
[...]
> @@ -563,14 +563,14 @@ int main(int argc, char **av)
[...]
>  	if (starts_with(cmd, "git-")) {
>  		cmd += 4;
>  		argv[0] = cmd;
> -		handle_internal_command(argc, argv);
> +		handle_builtin(argc, argv);
> -		die("cannot handle %s internally", cmd);
> +		die("cannot handle %s as a builtin", cmd);

I think this makes the user-visible message less clear.

Before when the user had a stale git-whatever link lingering in
gitexecdir, git would say

	fatal: cannot handle whatever internally

which tells me git was asked to handle the whatever command internally
and was unable to.  Afterward, it becomes

	fatal: cannot handle whatever as a builtin

which requires that I learn the jargon use of "builtin" as a noun.
busybox's analogous message is "applet not found".  It's less likely
to come up when using git because it requires having a stray link to
"git".  A message like

	$ git whatever
	fatal: whatever: no such built-in command

would just leave me wondering "I never claimed it was built-in; what's
going on?"  I think it would be simplest to keep it as

	$ git whatever
	fatal: cannot handle "whatever" internally

which at least makes it clear that this is a low-level error.

The rest of the patch looks good.

Thanks,
Jonathan
