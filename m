From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/10] git-submodule.sh: don't use the -a or -b option
 with the test command
Date: Thu, 15 May 2014 08:58:22 -0700
Message-ID: <20140515155821.GA27279@google.com>
References: <1400163457-28285-1-git-send-email-gitter.spiros@gmail.com>
 <1400163457-28285-10-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 17:58:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wky3I-00089o-0R
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 17:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbaEOP6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 11:58:31 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:55441 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbaEOP6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 11:58:30 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so1273840pbc.15
        for <git@vger.kernel.org>; Thu, 15 May 2014 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bceL4HQjLKp94QQmVOS3ZdVh5VFfdRXj4u7S7VShwt4=;
        b=jnPmkMyRB/atf5X8FeHzHW6Nk3coi8W3TZ2S9NQfYee71ZDgmZ2bcSB9FE4JpmsvL4
         l9vmOs7OYwuMTPJAA7tOuLydx22CGdpGIVkh4qdT7ykFKsAsaULo12EBJNMIJE9T/PRs
         oQYs+eBjt4wQTAsWj4OF4cBDVny4wsyg97q3opkEJHbVrKoWnB/ajabGzsPEjG3tEGQZ
         nKVeGjEDqjEz5liJ/CUFx3YIwDLAZsuDtTwdP9RytsuBlT/JCAIT/u+WjYqoUbhXjZth
         aYYTipJJ6XoPn8RK2O3jRw4G0Agv9N+GmJH4vYUNLpZ1OYtRZ9Tip38kVyEkx4g6Pl6m
         zAvA==
X-Received: by 10.68.235.6 with SMTP id ui6mr13257117pbc.45.1400169510120;
        Thu, 15 May 2014 08:58:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iq10sm9795977pbc.14.2014.05.15.08.58.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 08:58:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400163457-28285-10-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249104>

Elia Pinto wrote:

> Even though POSIX.1 lists -a/-o as options to "test", they are
> marked "Obsolescent XSI". Scripts using these expressions
> should be converted  as follow:
[... many lines snipped ...]

This is a very long description, and it doesn't leave me excited by
the change.

Is there some potential bug this prevents, or is it just a style
fix?  If the latter, do we have a way of checking for new examples
of the same thing to avoid having to repeat the same patch again in
the future?

Are there any platforms that were broken which this fixes?  Even
posh seems to understand -a and -o.

Nowadays Documentation/CodingGuidelines says

 - Fixing style violations while working on a real change as a
   preparatory clean-up step is good, but otherwise avoid useless code
   churn for the sake of conforming to the style.

   "Once it _is_ in the tree, it's not really worth the patch noise to
   go and fix it up."
   Cf. http://article.gmane.org/gmane.linux.kernel/943020

which I think goes too far (some patterns really are error prone
or distracting and it can be worth fixing them tree-wide), but it
makes a reasonable case that an idiom not being preferred in the
style guide is not *on its own* enough reason to change it.

Perhaps something like the following would work?

	tree-wide: convert test -a/-o to && and ||

	The interaction with unary operators and operator precedence
	for && and || are better known than -a and -o, and for that
	reason we prefer them.  Replace all existing instances in git
	of -a and -o to save readers from the burden of thinking
	about such things.

	Add a check-non-portable-shell.pl to avoid more instances of
	test -a and -o arising in the future.

[...]
> -			test $status = D -o $status = T && echo "$sm_path" && continue
> +			 ( test $status = D || test $status = T ) && echo "$sm_path" && continue

There's no need for a subshell for this.  Better to use a block:

			{
				test "$status" = D ||
				test "$status" = T
			} &&
			echo "$sm_path" &&
			continue

or an if statement:

			if test "$status" = D || test "$status" = T
			then
				echo "$sm_path"
				continue
			fi

or case:

			case $status in
			D|T)
				echo "$sm_path"
				continue
				;;
			esac

Hope that helps,
Jonathan
