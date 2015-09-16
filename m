From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "Medium" log format: change proposal for author != committer
Date: Tue, 15 Sep 2015 18:52:56 -0700
Message-ID: <xmqq8u87t9jb.fsf@gitster.mtv.corp.google.com>
References: <robbat2-20150915T214920-375711965Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 03:53:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc1uB-00018k-Mw
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 03:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbbIPBw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 21:52:59 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36331 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbbIPBw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 21:52:58 -0400
Received: by padhk3 with SMTP id hk3so192745355pad.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9MeKZtuA0QS4ZwgtVacq+ng8JPyO9d1rWrT1y5gy3DA=;
        b=x4mFPFeXK8S7F6q+uCTRd3YesA59AQCsgH4+ShJM2ddsvAcs8n6fdc713qjZw18gL3
         Myfryn3c+E6nSPfix49WRp4Ah6mEAZb++7z0LOE/azMI9VqTkbf0JpgsIlW0h3KtXdpm
         h2OYks6THO0GX2tdbLX3Ng9drHfpZUaWg0IN0Bz6LI7kUYmBtafm6xiJPrmEx889XuVw
         eSEu+VghQ4+iVbMFqzX5ritZ9t+tPTmwYZzlfRK+fJxsAK+CveXcSI0OYpS4m0JNEAfl
         PyTsdwbSxeu8iELWT9tpqz5W96SbsunXBnx2BLDXR2igq7T19XU3Mnv2cZfulcM+Lf4L
         Sk2g==
X-Received: by 10.68.254.99 with SMTP id ah3mr53538091pbd.15.1442368378223;
        Tue, 15 Sep 2015 18:52:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id g5sm22982459pat.21.2015.09.15.18.52.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 18:52:57 -0700 (PDT)
In-Reply-To: <robbat2-20150915T214920-375711965Z@orbis-terrarum.net> (Robin
	H. Johnson's message of "Tue, 15 Sep 2015 21:52:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277995>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> Specifically, if the author is NOT the same as the committer, then
> display both in the header. Otherwise continue to display only the
> author.

I too found myself wanting to see both of the names sometimes, and
the "fuller" format was added explicitly for that purpose.

Even though I agree "show only one, and both only when they are
different" is a reasonable and possibly useful format, it is out of
question to change what "--pretty=medium" does.  It has been with us
forever and people and their scripts do rely on it.

It would be good if we can say

    $ git log --pretty=robinsformat

but with a better name to show such an output.


Having said that, I'm moderately negative about adding it as yet
another hard-coded format.  We simply have too many, and we do not
need one more.  What we need instead is a flexible framework to let
users get what they want.

I think what needs to happen is:

 * Enhance the "--pretty=format:" thing so that the current set of
   hardcoded --pretty=medium,short,... formats and your modified
   "medium" can be expressed as a custom format string.

 * Introduce a configuration mechanism to allow users to define new
   short-hand, e.g. if you have this in your $HOME/.gitconfig:

	[pretty "robin"]
        	format = "commit %H%nAuthor: %an <%ae>%n..."

   and run "git log --pretty=robin", it would behave as if you said
   "git log --pretty="format:commit %H%nAuthor: %an <%ae>%n...".

 * (optional) Replace the hardcoded implementations of pretty
   formats with short-hand names like "medium", "short", etc. with a
   built-in set of pretty.$name.format using the configuration
   mechanism.  But we need to make sure this does not hurt
   performance for common cases.
