From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Fri, 28 Sep 2012 08:37:09 +0700
Message-ID: <CACsJy8AbVi-uR2-5Ndz3cTAzz_=xahOSpTBGOsB2XdYTsYtG6w@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com> <CAJo=hJt0PdpDT5ROUSfZ80Zh2ep=r5Sg1BS=v7Ve-djydHhp-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 03:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THPWY-0007CI-Ow
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 03:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124Ab2I1Bhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 21:37:41 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59405 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab2I1Bhk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 21:37:40 -0400
Received: by ieak13 with SMTP id k13so6150540iea.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 18:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TIiayo9pftX6lKD3ppNwtSSIOfAwu1CbysjtUxlzoDM=;
        b=vhf+bwaZc5Rb62beDqju7oh2i5psBGIzr1ArTLpFG2wCEENGpc8o+HwI+5xYGXd8or
         28h3oHcD7p5cxg0FlIwsz1prpIpEKAcH9OQL6xWwguCQNPc63vCptMt1ImFEAAkek9EQ
         r8we0ReBcU1v15Q7c3kzsijG/MythNJnGV9B25c9KJqNkmrwlQUYeza06Z/wnYNk0LeC
         aU7n0ITJ6wJmMtzRO4oey4JmkRtA+WanJSt0IUgK1Jy2QB124Zek7t24mYG1fr3YHNyA
         Ded5z6nMUriDzyJ0k0zMkB9+L9zhwlnXTHwzT6wFCD2TxOxr1FR0jNyD6JrbKwxSuo9z
         CjJA==
Received: by 10.42.129.83 with SMTP id p19mr4528750ics.9.1348796259883; Thu,
 27 Sep 2012 18:37:39 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Thu, 27 Sep 2012 18:37:09 -0700 (PDT)
In-Reply-To: <CAJo=hJt0PdpDT5ROUSfZ80Zh2ep=r5Sg1BS=v7Ve-djydHhp-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206532>

On Thu, Sep 27, 2012 at 9:33 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> I'd like to see some sort of extension mechanism like in
>> $GIT_DIR/index, so that we don't have to increase pack index version
>> often.
>
> This might be worthwhile. I dislike the way $GIT_DIR/index encodes
> extensions. Forcing an extension to fully materialize itself to
> determine its length so the length can be placed before the data is
> painful to work with when writing the file out to disk. I would prefer
> writing an index catalog at the trailer of the file. We already
> require random access to the index file, so its possible for a reader
> to read a fixed size trailer record that has the 2 SHA-1s we normally
> end an index with, and an extension catalog footer that has a length
> and CRC-32 of the catalog. The catalog would immediately appear before
> the footer, so a reader can find the start of the extension catalog by
> subtracting from the end of the file the catalog length and the file
> footer and catalog footer lengths. The catalog can then supply a
> starting offset for each extension section, and writers don't need to
> predict in advance how much data they need to store. Readers trying to
> use extensions aren't really hurt, Git already randomly seeks to read
> the tail of an index file to compare the pack SHA-1 before assuming
> the index is valid.

Yeah, that's exactly what I had in mind. But perhaps a separate file
(or files?) may be better. On that point, should all extensions be in
one new extra file, or one extension per file? I prefer all extensions
in one file, so we only need a single additional stat() for extension
check instead of probing for the entire pack-XXX.* range. In that
case, the catalog trailer idea still applies.
-- 
Duy
