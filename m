From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git log history simplification problem
Date: Tue, 4 Feb 2014 11:48:42 -0800
Message-ID: <20140204194842.GM30398@google.com>
References: <20140204173713.GC17861@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@collabora.co.uk>
X-From: git-owner@vger.kernel.org Tue Feb 04 20:48:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAlzG-0005sx-B5
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 20:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbaBDTsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 14:48:47 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37274 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaBDTsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 14:48:45 -0500
Received: by mail-pd0-f174.google.com with SMTP id z10so8685748pdj.33
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 11:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/PpaRHnX90h+q0OqbDgltexBX/iotOoYBmyZcChHXlU=;
        b=kw0w1LaewJFABQh3vMMQ9qKKRdQZAYLBrL7TQNamjJi/onvDpGmazvZq8rgT5pHDQ8
         hSpKr4AVgOmYOhCe4yhg1p4IE4xqfPKM+h0z7cIjdRzebMHA6vyIS98q4zJlsYAYfiMs
         T4GOn/9RAu1FWf028+4QGABg+A2Bw3mGdvPnHTxk9kAQM+NNX1BhC6GVn2jXrTMMWNyH
         wE92y10lmoYyyXxCtVWGMYiRJ4zEp9hXY2rcHMcGNXacf6Pb9YQ6YlR9Lrdppo18MdEp
         3xqpJ8s+MjmZErjkXtYnGbchCYq5Rk3FKhWcE3BkMQocWwvXINm0zMZyFkcwWpivsp3H
         yTjg==
X-Received: by 10.66.189.193 with SMTP id gk1mr46120491pac.105.1391543325158;
        Tue, 04 Feb 2014 11:48:45 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id eo11sm177272960pac.0.2014.02.04.11.48.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Feb 2014 11:48:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140204173713.GC17861@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241542>

Hi,

Miklos Vajna wrote:

> git clone git://anongit.freedesktop.org/libreoffice/core
> cd core
> git log --full-history -p -S'mnTitleBarHeight =' sd/source/ui/dlg/PaneDockingWindow.cxx
>
> Here the first output I get from git-log is
> b390fae1706b9c511158a03e4fd61f263be4e511, where you can see that the
> commit *added* that string. So it should be there on master, I would
> assume.

df76bfb0695d19d201936df80192108e7ce51b8c (a merge) removed it.

Plain 'git log' doesn't notice because in the default mode it skips
merges.

Since the culprit commit is not in the first-parent history of HEAD,
my usual approach doesn't help, either:

	$ git log -m --first-parent -S'mnTitleBarHeight =' \
		-- sd/source/ui/dlg/PaneDockingWindow.cxx
	$ 

Using -c or --cc produces too many hits.

Luckily '-m -p' without --first-parent worked and the first commit it
showed was the right one.  It produces more hits than I'd like, too,
though.

The -L option doesn't interact well enough with --reverse to handle
this case:

	$ git grep -p -e'mnTitleBarHeight =' b390fae1 -- sd/source/ui/dlg/PaneDockingWindow.cxx
	b390fae1:sd/source/ui/dlg/PaneDockingWindow.cxx=void PaneDockingWindow::Layout (void)
	b390fae1:sd/source/ui/dlg/PaneDockingWindow.cxx:    mnTitleBarHeight = GetSettings().GetStyleSettings().GetTitleHeight();
	b390fae1:sd/source/ui/dlg/PaneDockingWindow.cxx:            mnTitleBarHeight = aToolBoxSize.Height();
	b390fae1:sd/source/ui/dlg/PaneDockingWindow.cxx:        mnTitleBarHeight = aToolBoxSize.Height();
	$ git log --reverse b390fae1..HEAD \
		-L:Layout:sd/source/ui/dlg/PaneDockingWindow.cxx
	fatal: -L parameter 'Layout' starting at line 1: no match

Thanks for a useful example.
Jonathan
