From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Wed, 5 Jan 2011 16:56:09 +0000
Message-ID: <AANLkTimHb8O6s_KfhSGqvStZkEGWvPeAVcqQkYoyk49j@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 17:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaWen-0002R8-3t
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 17:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab1AEQ4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 11:56:12 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62456 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab1AEQ4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 11:56:10 -0500
Received: by qyk12 with SMTP id 12so17567901qyk.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+u69ANQW35zHo/h8EQwbJgy4Eei2XWy5NZbP78bEaZ4=;
        b=MGTlPGTkeZ8JfbAvOy7dP6Ujf8Vsz2tvgZc4P2pkHrswUAeKjYcSQXm409qfdoj4fR
         WdFqnlNUIp7S7LDOYQ35RdwVQkWCvf3iN2kSL1h04LvAkk1j3AThYx+3S9XYj2pIDPNR
         uZk+wx8OhZIFoZaC4QLSB8HHgZvKxeB5fNcew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=k0wHWqwitEogySL8e7BiHfZI61xgsvSI2hIZcQgEAgafpha4RwU72WoeqmIgVuxdZ0
         EjPzWVtsZFz7nTtMuF3wpmdzWgHzbYNZyxU9ldyXItgYrVGGSBRCh8kih6eIILR4jftW
         kEE99nklL0hTTym22gOnScsnjFWxlguYwEL4Y=
Received: by 10.224.60.211 with SMTP id q19mr22396995qah.69.1294246569843;
 Wed, 05 Jan 2011 08:56:09 -0800 (PST)
Received: by 10.220.190.203 with HTTP; Wed, 5 Jan 2011 08:56:09 -0800 (PST)
In-Reply-To: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164574>

On Wed, Jan 5, 2011 at 4:23 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Hi,
>
> I've been analyzing bittorrent protocol and come up with this. The
> last idea about a similar thing [1], gittorrent, was given by Nicolas.
> This keeps close to that idea (i.e the transfer protocol must be around git
> objects, not file chunks) with a bit difference.

> So it all looks good to me. It is resumable and verifiable. It can be
> fetched in parallel from many servers. It maps pretty good to
> BitTorrent (which means we can reuse BitTorrent design). All transfer
> should be compressed so the amount of transfer is also acceptable (not
> as optimized as upload-pack, but hopefully overhead is low). A minor
> point is latest commit (in full) will be available as soon as
> possible.

 ok.  what i wasn't aware of, about the bittorrent protocol, was that
multiple files, when placed into the same .torrent, are just
concatenated as one monolithic data block.  the "chunking" is just
then slapped on top of that.  the end result is that it's possible
that, if you want to get one specific file (or, in this case "object"
whether it be commit, blob or tree) then you *might* end up getting
two more "chunks" than you actually need, which, worst case could end
up being 2.999x the actual data really required.

 _this_ is the reason why people such as cameron dale criticised
bittorrent as a hierarchical / multi-file delivery mechanism (and
abandoned it in favour of apt-p2p), and i didn't understand this at
the time enough to be able to point out that i'd assumed they knew
what i was thinking :)

 what i was thinking was "duhh!" don't slap multiple files into a
single .torrent, put each file (or, in this case "object" whether it
be commit, blob, tree or other) into a separate torrent!  that's all -
problem goes away!

 now that of course leaves you with the problem that you now have
potentially hundreds if not thousands or tens of thousands of
.torrents to deal with, publish, find etc. etc.   and the solution to
_that_ is to give the name of the .torrent file something
meaningful.... like.... ooo, how about... the object's md5 sum? :)

 so _that_ problem's solved, which leaves just one more problem: how
to find such a ridiculously large number of objects in the first
place, and, surprise-surprise, there's a perfect solution to that, as
well, called DHTs.  and, surprise-surprise, what do you need as the
DHT key?  something like a 128-bit key?   ooo, how about ... the
object's md5 sum? that's 128-bit, that'll do :)

 but, better than that: there happens to have been announced very
recently an upgraded version of a bittorrent client, which claims to
be fantastic as it's no longer dependent on "internet search" sites,
because surprise-surprise, it uses peer-to-peer DHT to do the search
queries.

 so not only is there a solution to the problems but also there's even
a suitable codebase to work from in order to create a working
prototype.

 now i just have to find the damn thing... ah yes, it's called Tribler.

 l.
