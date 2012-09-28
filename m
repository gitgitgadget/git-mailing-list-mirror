From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Fri, 28 Sep 2012 19:00:28 +0700
Message-ID: <CACsJy8AUdRyjSrAgM+ABzWet2NKz7N7M4re2QVoRPrrA=zfvvg@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 14:01:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZFl-0007SN-3u
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab2I1MBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:01:00 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55527 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2I1MA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:00:59 -0400
Received: by ieak13 with SMTP id k13so7044986iea.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8WF/yOl2Q/Y8O70mn8j/6StCggUqcO/C2P/hR593VQI=;
        b=Lf6wiDuUwkO5N4LTEPpN29mBP53VhKL6vNBIkPzrzpopgQyzLvdeWAo6GRFolinVH7
         INgFi6ueM5/JLr9SoyhLetTQ0IN1i+AZU7dZsirQ5hjf6WxGVOoXSge3bQ/H0iT1i7Sr
         JaK0KZYGMhdpKozxKVqnD/soqoU2RUxfZ0kMUkbWAycnw7BJ2JwHJMgrz12TS65QnnB3
         IdNY+IWg0y9UvDQwp6U88k+vsBUxOKNc6ul0Eo0ysGdCdQeAyGHFeX4J7UglHMmXJW16
         sCNWjsLLS5d0lny8Mju9Kw+XSBsZPwnLire702Zn1VFiPiZHRXfuhbo7y43rjasN/B+b
         v7PA==
Received: by 10.50.53.199 with SMTP id d7mr1354711igp.47.1348833658825; Fri,
 28 Sep 2012 05:00:58 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Fri, 28 Sep 2012 05:00:28 -0700 (PDT)
In-Reply-To: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206556>

On Thu, Sep 27, 2012 at 7:47 AM, Shawn Pearce <spearce@spearce.org> wrote:
> * https://git.eclipse.org/r/7939
>
>   Defines the new E003 index format and the bit set
>   implementation logic.

Quote from the patch's message:

"Currently, the new index format can only be used with pack files that
contain a complete closure of the object graph e.g. the result of a
garbage collection."

You mentioned this before in your idea mail a while back. I wonder if
it's worth storing bitmaps for all packs, not just the self contained
ones. We could have one leaf bitmap per pack to mark all leaves where
we'll need to traverse outside the pack. Commit leaves are the best as
we can potentially reuse commit bitmaps from other packs. Tree leaves
will be followed in the normal/slow way.

For connectivity check, fewer trees/commits to deflate/parse means
less time. And connectivity check is done on every git-fetch (I
suspect the other end of a push also has the same check). It's not
unusual for me to fetch some repos once every few months so these
incomplete packs could be quite big and it'll take some time for gc
--auto to kick in (of course we could adjust gc --auto to start based
on the number of non-bitmapped objects, in additional to number of
packs).
-- 
Duy
