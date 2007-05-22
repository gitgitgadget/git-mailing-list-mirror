From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Tue, 22 May 2007 13:13:21 +0200
Message-ID: <e5bfff550705220413v261e1543s220d97ce4b9da07b@mail.gmail.com>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	 <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	 <7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
	 <7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
	 <7vmyzyhdfh.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705210423i34dc481es61d3b886ae77c5f7@mail.gmail.com>
	 <7vbqgdbq5j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 13:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqSJ0-0006MP-OE
	for gcvg-git@gmane.org; Tue, 22 May 2007 13:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbXEVLNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 07:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755280AbXEVLNX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 07:13:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:17451 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbXEVLNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 07:13:22 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1717506wra
        for <git@vger.kernel.org>; Tue, 22 May 2007 04:13:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d0SeMkzxvxn6pfvkjKSSeXFuxYZYbuIcRn+2C1BVq4qw0IzT+FoRZR1QMg4oOHqfcJoiYnzjeca+krSmz38+52f+5r1b99LFWqoJaVjip7ajGGMnXXKfLaz4D20c9INFqYE0qylPAx6fIVQKin4pilPd9mA3g7KCDSckwLNP+aM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b3li01d2Tnt9GdK1EU3lFXoikDx8mWBBeWXEc7LtNQ2ofOvsKmfyqQMNvKbwkYmW53mXYyIygYgOamVHQ6GJmTEFGga4gGo6NB7gzwcGZ9023/oQS/Ntl7C25t+rJ7GdvwYyXoQh9si3SPfbTP9zZJS6DzlJ6Jz7GgbiQqOUMdw=
Received: by 10.114.201.1 with SMTP id y1mr3229524waf.1179832401208;
        Tue, 22 May 2007 04:13:21 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Tue, 22 May 2007 04:13:21 -0700 (PDT)
In-Reply-To: <7vbqgdbq5j.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48092>

On 5/22/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > On 5/21/07, Junio C Hamano <junkio@cox.net> wrote:
> >> Junio C Hamano <junkio@cox.net> writes:
> >>
> >>
> >> We somehow end up removing one LF too many, like this:
> >>
> >>     diff --git a/contrib/emacs/.gitignore b/contrib/emacs/.gitignore
> >>     index c531d98..016d3b1 100644
> >>     --- a/contrib/emacs/.gitignore
> >>     +++ b/contrib/emacs/.gitignore
> >>     @@ -1 +1 @@
> >>     -*.elc
> >>     +*.elc
> >>     \ No newline at end of file
> >>
> >

The final, and correct version is:

       if (new_whitespace == strip_whitespace && trailing_added_lines)  {

	int n = 0;
	for (   ; n  <= trailing_added_lines; n++)  { /* counting trailing '\n' */

		if (newsize == n)  {
			n++;
			break;
		}
		if (new[newsize - 1 - n] != '\n')
			break;
	}
             trailing_added_lines = (n>0) ? --n : 0;
      }  else
	trailing_added_lines = 0;


but I understand is ugly as hell. The fact is, it is far easier to
count '\n' *while* they are created then after at the end.


So no problem for me if you drop my patch.


  Marco
