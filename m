From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: pack-object's try_delta fast path for v2 trees?
Date: Tue, 15 Oct 2013 07:49:57 +0700
Message-ID: <CACsJy8DgjCR+B+Bvbydns=bCZP5=TU1avPinnuDKqLZXS=4LNQ@mail.gmail.com>
References: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
 <20131015001926.GC10415@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 02:50:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVsqQ-0005eS-0X
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 02:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab3JOAu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 20:50:28 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:40291 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab3JOAu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 20:50:27 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so96640obc.21
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 17:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UXwCJ0bMkTTvp2oG5BVDlD5KKJdvvaMvh76d2V8LVgM=;
        b=S151rl9QwMMiCMUM1MXV+PvPNuqKLPcNTpSwh/ef4nZrbPEBGaTApdovE4Q5FQuheP
         KBkiBSqNGaw8n//WyGhaxKVZRRcOmqmra1+UjaUzqqrUTKsMhaAKRx85CX8C5tbcJICA
         2GozbxI0YfxwHmrrnVN2iHxavlK/IsZfuIyxU2pmAtwt6wGeZrrSubZxV2DKv/nRa1iX
         8wMWzQdBNgQDYpMoCrD2U83eYaH4Zm+MBx2htXT5QSO2+Cf5h3Q0NcnnxikGeRl/iTv5
         hISsVx1k+/yCoPmo0G1PnQOtWJRt6/mAHTY32ClXTKFDcUV0BXj3lpZfIVQr9NSWSwc+
         T8mQ==
X-Received: by 10.182.250.163 with SMTP id zd3mr30687854obc.20.1381798227127;
 Mon, 14 Oct 2013 17:50:27 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Mon, 14 Oct 2013 17:49:57 -0700 (PDT)
In-Reply-To: <20131015001926.GC10415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236158>

On Tue, Oct 15, 2013 at 7:19 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Oct 12, 2013 at 10:42:17AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> Just wondering if this has been considered and dropped before.
>> Currently we use try_delta() for every object including trees. But
>> trees are special. All tree entries must be unique and sorted. That
>> helps simplify diff algorithm, as demonstrated by diff_tree() and
>> pv4_encode_tree(). A quick and dirty test with test-delta shows that
>> tree_diff only needs half the time of diff_delta(). As trees account
>> for like half the objects in a repo, speeding up delta search might
>> help performance, I think.
>
> No, as far as I know, it is a novel idea. When we were discussing commit
> caching a while back, Shawn suggested slicing trees on boundaries and
> store delta instructions that were pure "change this entry", "add this
> entry", and "delete this entry" chunks. The deltas might end up a little
> bigger, but if the reader knew the writer had sliced in this way, it
> could get a packv4-style cheap tree-diff, while remaining backwards
> compatible with implementations that just blindly reassemble the buffer
> from delta instructions.
>
> I didn't get far enough to try it, but doing what you propose would be
> the first step. Now that packv4 is more of a reality, it may not be
> worth pursuing, though.

I see this as pack-objects peformance improvements only. If we could
make pack-objects run like 10% faster (even only with -adf), then it
may be worth trying. The 10% is a total guess though as I haven't
checked how much time we spend in searching deltas.
-- 
Duy
