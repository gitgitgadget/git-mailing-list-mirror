From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g. ImageMagick's
Date: Mon, 23 Jul 2012 14:34:17 -0700
Message-ID: <CAJDDKr71SYf3=iUahGLVA2kmKYqT85Thaiooo2YCJqprS5nVag@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFB19.6010905@gmail.com>
	<7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
	<500DA7F3.3000403@gmail.com>
	<7v4noykxvm.fsf@alter.siamese.dyndns.org>
	<CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
	<7vipdejhmh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:34:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StQGl-0003wt-SV
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab2GWVeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:34:19 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36274 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab2GWVeS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:34:18 -0400
Received: by vbbff1 with SMTP id ff1so5175773vbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fnHk4oEOBSN5DdaZ2vC20RCmLhRvTQKMjHc+smqEcro=;
        b=i40k/sxvAM8+qJ5D1WPylT6aLDNmNCzImcrAbqhQMXiVRtkJu8/kdRfjTqZdDkkhAa
         KFwaq6Y+K/H7Pvqs0/46kiJGJlN5sOrpmQH8xFX88v8G2RVrwv/bwNVceTvyOPxbGb00
         fZWOq56+iuqu3cJwl+JyNk6BN2KHQJ8/w4YN6OKvHB4kP0KcUSdRoo35/zfyh3x7q5iJ
         EfZ2ZKHXjj6wnP7QmeCYuZUf/AAwcLOxnhN48VV0IRpkysLu7x2M3k1K2XRISibCOvdt
         ykc4u1UP4G4C7aJ1WuDICucyJBwEYkc7530Hf8FBDRRkuDnvZUj2QwBamjP6r0meQ9os
         yxog==
Received: by 10.220.16.8 with SMTP id m8mr13816063vca.10.1343079257475; Mon,
 23 Jul 2012 14:34:17 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Mon, 23 Jul 2012 14:34:17 -0700 (PDT)
In-Reply-To: <7vipdejhmh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201990>

On Mon, Jul 23, 2012 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sebastian Schuberth <sschuberth@gmail.com> writes:
>
>> We have no such assurance. That's why you correctly call it a
>> heuristics after all
>
> ImageMagick "compare" takes "--version" and says something like
> this to its standard output:
>
>     $ compare --version
>     Version: ImageMagick 6.6.0-4 2012-05-02 Q16
>     http://www.imagemagick.org
>     Copyright: Copyright (C) 1999-2010 ImageMagick Studio LLC
>
> Does Araxis compare take "--version" and behave in a way that is
> cheaply controllable?  If it opens a GUI window and pops up a dialog
> that says "Option not understood", then it is not "controllable",
> but if it quickly dies with "No such option" sent to the standard
> error output, or sending its version string to the standard output,
> then we could use something like:
>
>         case "$(compare --version 2>/dev/null)" in
>         "Araxis compare version"*)
>                 echo compare ;;
>         *)
>                 echo "$1" ;;
>         esac
>
> instead, and that would be more robust than the path based
> heuristics.

Araxis compare (the one I have) does not accept --version.

Also, the GraphicsMagick (ImageMagick fork) compare does not have
--version, but it does have "compare version":

$ compare version
GraphicsMagick 1.3.12 2010-03-08 Q8 http://www.GraphicsMagick.org/
Copyright (C) 2002-2010 GraphicsMagick Group.
Additional copyrights and licenses apply to this software.
See http://www.GraphicsMagick.org/www/Copyright.html for details.
...


If we care to blacklist *Magick compare, then we may be able to call
"compare version" and parse the output looking for "Magic".

I tested ImageMagick compare and it also understands "compare version".


Araxis compare prints nothing when "compare version" is called.
Likely because it thinks it has nothing to do.  It does the same if I
say "compare blahblah", and returns exit status 0.  So its output is
useless.

It seems like the best we can do is specifically blacklist the *Magick
"compare" commands so that they do not show up as false positives.
And the only way to identify them is to parse their output, since all
commands return status 0 for "compare version".


Another possibility is to parse the output of "compare" (no args) and
grep for "merge".  The name "Araxis Merge" is never actually printed,
but the help text for "-merge" does appear.... yep.. it's a heuristic.

Sebastian, are you testing on Windows?  The araxis "compare" I used is
OS X.  Does "compare version" open a GUI window for you?  For me it
does not.
What about "compare -h", or just "compare" ?
-- 
David
