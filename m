From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to manage parameter files and code separately using git?
Date: Sat, 01 May 2010 10:18:55 -0700
Message-ID: <7vmxwj5ym8.fsf@alter.siamese.dyndns.org>
References: <op.vb0195s1a8ed4e@dellschleppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tilo Schwarz" <tilo@tilo-schwarz.de>
X-From: git-owner@vger.kernel.org Sat May 01 19:19:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GLR-0002GT-Dl
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab0EARTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:19:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab0EARTC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:19:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8550AFC0C;
	Sat,  1 May 2010 13:19:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=90oRUhwLNuR2YCRk/XdhbJvIPB4=; b=QDyEEHAgead3D1wtEH1Y/+Q
	OgChB2B1xURVzU42Wx7KYpLfwipvjEBohQfUJ/k4EqOWR51ftaU1jMmhxu1sHytj
	uAwBmZdDQy5SQ8aiLIx5PPqKsm06ZgOGnf17R25krkwEgiy1hEojecHYIlobRLWU
	OXswmfpsUMhZBe/Vaj24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KGyad6XjP6Qu+o0Ti90wIHokeYPkx1p/Mob/2L/1nK3as7j0h
	WMw7ug99gqCMbo22mGMiu/AfUTzXDP59+/usa7p+w1BYbD2mdYC/wCvK7ilKch/2
	v5fSCKf3d3jGv+xHntcGc9w8lT7BCvfAO/obgacPYvefCyPY7F5k7u4j0k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 937F5AFC0A;
	Sat,  1 May 2010 13:18:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6F3AAFC09; Sat,  1 May
 2010 13:18:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A18A70E2-5545-11DF-BF3C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146097>

"Tilo Schwarz" <tilo@tilo-schwarz.de> writes:

> I use git for "normal" c coding, i.e. having branches like master, test,  
> foo, etc. Built are executables (Linux), which need parameter text files  
> to work. What I did up to now was to check in the parameter files in the  
> same way I check in the code: when I change a parameter file, I do a  
> commit on it, this way I always have a history of my parameter files.
>
> This has one drawback: If I check out an older version, I also get the old  
> parameter file, which is not what I want, because the parameters are  
> determined by hardware settings. I.e., I would like to checkout an old  
> commit, but still have the last version of the parameter file.

This design constraint makes the issue not a version control problem but
more of a software engineering problem.  The changes to your parameter
file have its own history (e.g. you upgraded your machine last week with
different hardware---the software didn't change but the parameter has to)
and the history is largely independent of the software that reads the
file.  In that sense, you should _never_ tie its history with the history
of your software.

At the same time, the history of the parameter file is not completely
independent of that of the software.  You may have added a new feature and
code to read a new setting in the parameter file today and older parameter
file would not have a setting for that variable.

The method I used in my day-job project is something like this:

 - Include a "config.sample" file and track it in the history of the
   source code; the values it gives to the variables are the same as the
   default ones.  This file mostly serves as a documentation.

 - Design your parameter mechanism in a way that:

   - a parameter file can include another;

   - an unrecognized parameter setting is ignored;

   - a variable definition that happens later overrides an earlier
     definition.

 - Have a real parameter file that is _not_ tracked in the history of the
   source code.  Have it include parameter.sample and then define machine
   specific settings after that to override.

It is only required for the "real" parameter file not to be tracked in the
history of the source code---it is perfectly fine to track it in a
separate history.  The easiest way to do this would be to keep a parameter
working tree next door, and "ln -s ../params/config config" in the working
tree for the source code.  You could keep this symlink tracked in the
source history, but you do not have to.

You will try to read from ./config, which will include ./config.sample in
order to read the default, and then read the customized setting that
appear later in ./config.  Because of the symlink, you will actually be
reading from ../params/config next door.
