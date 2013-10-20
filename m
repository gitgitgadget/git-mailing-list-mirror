From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: pack corruption post-mortem
Date: Sun, 20 Oct 2013 11:44:32 +0700
Message-ID: <CACsJy8AATr9KfFN6x0E8mYsBmWhVmD=kaXgBmnFTiyww3MS8WQ@mail.gmail.com>
References: <20131016083400.GA31266@sigill.intra.peff.net> <CACsJy8ABdE8mZMVFZkqYMC4ZeN_baWw=XcYOZYBCZytWP97rRw@mail.gmail.com>
 <alpine.LFD.2.03.1310191024000.1951@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Oct 20 06:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXktU-00060L-B8
	for gcvg-git-2@plane.gmane.org; Sun, 20 Oct 2013 06:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848Ab3JTEpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Oct 2013 00:45:04 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:37046 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab3JTEpD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Oct 2013 00:45:03 -0400
Received: by mail-qc0-f182.google.com with SMTP id n7so2032667qcx.27
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 21:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xu/Z6/6wn0WJ61IhcrjnMBkrPd8fND2YfdGJKLKXtpM=;
        b=ME70oWh1lYphBPIHr+l82duKQO3gso4XOBSINFkjpFuzPv6PiKCkkBy3qv8q3hKP0e
         x9PPQYaqvOOvfCcopi3MIxsfNQmnx0hy7oF4cEIAdqRiH7IpPmXAqbNrO7XWxf1NFlqy
         TShTT1p4MnQkRknKU7mef7wvy+CRHRg1g2xLmFQFKtBId956zIMvTl8DbpCH9xaZB/VC
         n7O0YWEvsFRQUmpgJNvazKsTPnxOXwUz41oWC0gRAA3f+XKKThHCYpREx+yc3ijHk8hB
         vZzbCpZp62CBQckTeQqYfPivz+jVbItAZnJ3Ditmkso5Gz7Med8Gyc6zlejLgFkWj3D3
         eXVA==
X-Received: by 10.49.98.100 with SMTP id eh4mr14405109qeb.42.1382244302258;
 Sat, 19 Oct 2013 21:45:02 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Sat, 19 Oct 2013 21:44:32 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1310191024000.1951@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236412>

On Sat, Oct 19, 2013 at 9:41 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 19 Oct 2013, Duy Nguyen wrote:
> The SHA1 used in the name of the pack file is actually the SHA1 checksum
> of the SHA1 table.
>
> The path and ident tables are already protected by the CRC32 in the zlib
> deflated stream.
>
> Normal objects are also zlib deflated (except for their header) but you
> need to inflate them in order to have this CRC verified, which the pack
> data copy tries to avoid.  Hence the separate CRC32 in the index file in
> that case.

OK slight change in the subject, what about reading code (i.e.
sha1_file.c)? With v2 crc32 is verified by object inflate code. With
v4 trees or commits, because we store some (or all) data outside of
the deflated stream, we will not benefit from crc32 verifcation
previously done for all trees and commits. Should we perform explict
crc32 check when reading v4 trees and commits (and maybe verify the
sha-1 table too)?
-- 
Duy
