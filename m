From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: possibly a spurious conflict in a three way merge
Date: Thu, 7 Aug 2014 11:52:43 -0700
Message-ID: <20140807185243.GE12427@google.com>
References: <53E3A99E.1090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: meanlogin@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 07 20:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFSnz-0004GC-61
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 20:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbaHGSwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 14:52:47 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33543 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbaHGSwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 14:52:46 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so3927554pde.39
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3hObckh0e8UvyKF+wJ+ST1j0ImY31fA73ihV3S/16CY=;
        b=ISy7T3LB49+niV+cp5YILB9QCH+goHx1mIb5TUsHrHjtcDvZ4Mn3L0+f5TdyLLlJnF
         xrh4jTfj1+fWAb1VCkbhYBXFoVVDNLhRjBfc9PKDd88VX4oeDrWViOX0+N352j/XPmk5
         SJZigGEkIgao+K4yKuPo68BXODM2PoYBKPzWQxPoPYFZjqM1VnxfAn6JeJdc7kon/WT+
         rig12Twu7/D7SDKnPBcCgS+lADRKo4Yy6khidMK0to7MHoW20gK22iaG3dcfL56prxwh
         ud1215+qKtUYPN5wU6nPJoeIyAOUjmij37eWyNs1votUlLEAeaecS9Xunnb0AJCo2RxP
         YSww==
X-Received: by 10.66.164.9 with SMTP id ym9mr4168277pab.139.1407437566416;
        Thu, 07 Aug 2014 11:52:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:9932:b877:7123:e96a])
        by mx.google.com with ESMTPSA id am3sm609287pbd.18.2014.08.07.11.52.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 11:52:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53E3A99E.1090102@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254986>

Hi,

meanlogin@gmail.com wrote:

> 2. commit test.txt to master:
> line1
> line1
>
> 3. branch and checkout branch1
> 4. make and commit the following change to branch1:
> #line1
> #line2
>
> 5. checkout master
> 6. make and commit the following change to master:
> line1
> #line2
>
> 7. merge branch1, git sees a conflict:
> <<<<<<< HEAD
> line1
> =======
> #line1
> >>>>>>> branch1
> #line2
>
> Why?

Thanks for a clear example.  On branch1 you made the following change:

 (a) modify lines 1 and 2

On master, you made a different change:

 (b) just modify line 2

The changes touch the same chunk of lines and don't produce the same
result there.  Git is being conservative and letting you know that the
two branches didn't agree about what line 1 should say.

On the other hand, if you had a larger files and on branch1 made the
following change:

 (a) modify lines 1 and 101

and on master, you made a different change:

 (b) just modify line 101

then the changes are touching different parts of the code and are
merged independently.  The result would be a clean merge where lines 1
and 101 are both modified.

Git's conservatism can be helpful when working with code, where
adjacent lines are likely to be affecting a single behavior and the
conflict can help the operator to know to be extra careful.  It makes
less sense for line-oriented input where every line is independent.

If you are often making changes to a line-oriented file, it may make
sense to set up a custom merge driver to override git's merge behavior
for that file.  See 'Defining a custom merge driver' in
gitattributes(5) for details about how that works.

Hope that helps,
Jonathan
