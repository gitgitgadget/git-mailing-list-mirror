From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the
 replaced one
Date: Sat, 7 Aug 2010 14:03:05 +1000
Message-ID: <AANLkTim9vMiEuBJJdCdGqjTOz8cs-nH+LyJF-rPGOTvS@mail.gmail.com>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com>
	<201008041457.31975.chriscool@tuxfamily.org>
	<AANLkTimVnAO6kCAo8N6DM9GX3z+DjKJgKizdTnktyb8Q@mail.gmail.com>
	<201008051341.08632.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Aug 07 06:03:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohacs-0000wD-16
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 06:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab0HGEDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 00:03:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57804 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0HGEDG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 00:03:06 -0400
Received: by wyb39 with SMTP id 39so8424164wyb.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 21:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Oed2GvkbREJjoiFkVHaXG263QEk8QIw3KR3GnXPWkzM=;
        b=Vbx6r/c/7BqhpylZxYVtjaBGXo1NAgdD/6Bj9b/6cYtBgodE55jARz5ROQ9OSsfVgk
         tm2ks7q8xrDAZoTWm1GHHWgQjUJNWHeXru5/g0Rfbxu9bzSDj5/edhBNxMuv1YwSfByk
         FVHadDaMny/3cEBPbfnZWWUilIniWizoYmV6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lRtSZO4Uu4ytPJgsxjS+m2qbo9SFTS7nNMk7yhScEgjX31Nhl7OuenhgVEWSZPj873
         mPVENWFN8uJYpA22+p0P1xTYnlB6GbI3GEwAJ3OO03c56vW9mkCfapGyW+yNM4Tamnnm
         oUGn8K8GPMtIr9gt1qGYZxRiApx+Oc11Gaga8=
Received: by 10.216.11.129 with SMTP id 1mr232411wex.90.1281153785146; Fri, 06
 Aug 2010 21:03:05 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Fri, 6 Aug 2010 21:03:05 -0700 (PDT)
In-Reply-To: <201008051341.08632.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152841>

On Thu, Aug 5, 2010 at 9:41 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> It looks like parse_commit() is buggy regarding replaced objects. But I am not
> sure how it should be fixed.

It could be fixed the same way you did with parse_object(): replace
read_sha1_file() with read_sha1_file_repl(). You would also need to
fix parse_tree() and parse_tag(). But..

> Anyway if you use parse_object(), then you don't need parse_commit(). So if
> possible you should use parse_object() instead of both lookup_commit() and
> parse_commit().

That's how those functions are used. For example, in
traverse_commit_list(), lookup_*() may be called and uninteresting
objects marked UNINTERESTING. Later on in process_{tree,blob,tag},
parse_* may be called if their content is interesting.

To me, the fix above will leave a gap when object->sha1 is the
original sha1, until parse_*() is called. It just does not sound good.

Or, you could lookup_replace_object() inside
lookup_{object,tree,commit,tag,blob} and update object->sha1. Hm..
-- 
Duy
