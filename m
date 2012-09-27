From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 11:36:19 -0700
Message-ID: <CAJo=hJs4NXatb2vsZWWCamLGLmi+FoWkTaf3Ky-nereXkHEptA@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
 <20120927172037.GB1547@sigill.intra.peff.net> <CAJo=hJuXCYa=MKSqCRsxmwFdFYZamK_94zc3fE0tmvwUAVA2Ow@mail.gmail.com>
 <20120927182233.GA2519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>,
	David Barr <barr@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:36:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THIx9-0000sG-OT
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 20:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab2I0Sgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 14:36:42 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35991 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2I0Sgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 14:36:41 -0400
Received: by qchd3 with SMTP id d3so1289572qch.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qNzAtXqoKm6iFRf+Q/vBPA99qk8u9NxKSmwZepmMHgI=;
        b=ZjVvDrq37wjV3tlZmYFEKV0hzn6mspwbQVDxmAhU4B72jkw/qr5h9ITuXQxwMufqT5
         9HclRhyDgqlWD31W9U3VixgQyvS6WjDw9df+UbissM+p3kSfOmNaKS43ZGcCTt7xXfKi
         TTbmBx3pXw+s6v7cMuZzPLyzefDi9pn/wVdX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=qNzAtXqoKm6iFRf+Q/vBPA99qk8u9NxKSmwZepmMHgI=;
        b=U7/2Wmcj9F9U0nLChWzAxLvU4UXYuXBIEu3mmsNEZVCV5nirGc9Nqu1DUhIYz0C5Cx
         pJNzx41lfjH32Dv16BP2HQ62JCIBx0stPfM2Tk7o1U6+B8wCbcjVAFQ17lOjAAjZPjjL
         sJ08Ul/SO/9vzoyJHRlG/jvZtD2RvaiDGLZuJVg5Vaobcx+fz/VgLNz9wHqQSsg/zjid
         tBLohSeme+D6vYgzzoQLeRcsaAFevWbE8zrQnGWNMsHgaOUW2QB6uGVh0zOAmdbF28D+
         Twr9BgqZ0iL8QX5DkEv3KtxliEfiuWBxxMmNMOYLQNKJ0jp5ObT847TYbqy+QDGFPksN
         sGww==
Received: by 10.229.135.143 with SMTP id n15mr3005560qct.77.1348771000503;
 Thu, 27 Sep 2012 11:36:40 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Thu, 27 Sep 2012 11:36:19 -0700 (PDT)
In-Reply-To: <20120927182233.GA2519@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQns04WmkfX0kV0BL/j+tsaila1qGjWtuOy2GoGHGHCQRXTXhWTMiib+NlOeZ6bB46DsItAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206506>

On Thu, Sep 27, 2012 at 11:22 AM, Jeff King <peff@peff.net> wrote:
>
> I think clients will also want it. If we can make "git rev-list
> --objects --all" faster (which this should be able to do), we can speed
> up "git prune", which in turn is by far the slowest part of "git gc
> --auto", since in the typical case we are only incrementally packing.

Yes, the bitmap can also accelerate prune. We didn't implement this
but it is a trivial use of the existing bitmap.

>> > The sha1 in the filename makes sure that the reachability file is always
>> > in sync with the actual pack data and index.
>>
>> Depending on the extension dependencies, you may need to also use the
>> trailer SHA-1 from the pack file itself, like the index does. E.g. the
>> bitmap data depends heavily on object order in the pack and is invalid
>> if you repack with a different ordering algorithm, or a different
>> delta set of results from delta compression.
>
> Interesting. I would have assumed it depended on order in the index.

No. We tried that. Assigning bits by order in index (aka order of
SHA-1s sorted) results in horrible compression of the bitmap itself
because of the uniform distribution of SHA-1. Encoding instead by pack
order gets us really good bitmap compression, because object graph
traversal order tends to take reachability into account. So we see
long contiguous runs of 1s and get good compression. Sorting by SHA-1
just makes the space into swiss cheese.

> I think you are still OK, though, because
> the filename comes from the sha1 over the index file, which in turn
> includes the sha1 over the packfile. Thus any change in the packfile
> would give you a new pack and index name.

No. The pack file name is composed from the SHA-1 of the sorted SHA-1s
in the pack. Any change in compression settings or delta windows or
even just random scheduling variations when repacking can cause
offsets to slide, even if the set of objects being repacked has not
differed. The resulting pack and index will have the same file names
(as its the same set of objects), but the offset information and
ordering is now different.

Naming a pack after a SHA-1 is a fun feature. Naming it after the
SHA-1 of the object list was a mistake. It should have been named
after the SHA-1 in the trailer of the file, so that any single bit
modified within the pack stream itself would have caused a different
name to be used on the filesystem. But alas this is water under the
bridge and not likely to change anytime soon.

>> Yes. One downside is these separate streams aren't removed when you
>> run git repack. But this could be fixed by  a modification to git
>> repack to clean up additional extensions with the same pack base name.
>
> I don't think that's a big deal. We already do it with ".keep" files. If
> you repack with an older version of git, you may have a stale
> supplementary file wasting space. But that's OK. The next time you gc
> with a newer version of git, we could detect and clean up such stale
> files (we already do so for tmp_pack_* files).

Yes, obviously.
