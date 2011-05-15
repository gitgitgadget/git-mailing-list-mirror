From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv3 3/9] pack-objects: Allow --max-pack-size to be used
 together with --stdout
Date: Sun, 15 May 2011 15:06:00 -0700
Message-ID: <BANLkTingc375Kzm-TBS4aQ_912pg7G03cQ@mail.gmail.com>
References: <201105151942.29219.johan@herland.net> <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 00:06:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLjSE-00029m-Hc
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 00:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab1EOWGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 18:06:21 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35256 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab1EOWGV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 18:06:21 -0400
Received: by vxi39 with SMTP id 39so2795308vxi.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 15:06:20 -0700 (PDT)
Received: by 10.52.114.104 with SMTP id jf8mr5228688vdb.193.1305497180113;
 Sun, 15 May 2011 15:06:20 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sun, 15 May 2011 15:06:00 -0700 (PDT)
In-Reply-To: <1305495440-30836-4-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173678>

On Sun, May 15, 2011 at 14:37, Johan Herland <johan@herland.net> wrote:
> Currently we refuse combining --max-pack-size with --stdout since the=
re's
> no way to make multiple packs when the pack is written to stdout. How=
ever,
> we want to be able to limit the maximum size of the pack created by
> --stdout (and abort pack-objects if we are unable to meet that limit)=
=2E
>
> Therefore, when used together with --stdout, we reinterpret --max-pac=
k-size
> to indicate the maximum pack size which - if exceeded - will cause
> pack-objects to abort with an error message.
=2E..
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pack_to_stdout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr_written !=3D nr_=
remaining)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("un=
able to make pack within the pack size"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 " limit (%lu bytes)", pack_size_limit);

I think this is too late. We have already output a bunch of data, up
to the size limit at this point. If the size limit is non-trivial
(e.g. 5 MB) we have already sent most of that to the remote side, and
its already written some of that out to disk.

I'd like this to be a soft limit derived from the reused object sizes.
When planning the pack by looking at where we will reuse an object
from, sum those sizes. If the sum of these sizes would break this
limit, then we abort before even writing the pack header out.

--=20
Shawn.
