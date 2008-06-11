From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 11:48:10 -0700
Message-ID: <832adb090806111148u5e13e9c5g7afc5b013e6f1223@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>
	 <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org>
	 <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>
	 <alpine.LFD.1.10.0806101935130.3101@woody.linux-foundation.org>
	 <832adb090806102258v3fd63605p8c45513690b78fe8@mail.gmail.com>
	 <832adb090806102318k5727bb06p6c3211a6aebbfbe9@mail.gmail.com>
	 <alpine.LFD.1.10.0806110752550.3101@woody.linux-foundation.org>
	 <832adb090806111052p32a750c2n5f2d43e0ed1b910d@mail.gmail.com>
	 <alpine.LFD.1.10.0806111105150.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 20:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6VOK-0005cf-1H
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 20:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565AbYFKSsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 14:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758561AbYFKSsO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 14:48:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:64569 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758554AbYFKSsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 14:48:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2208618fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+EInxMTe4MPcWqihgxV7Wv3G0CQmwF8n6sEiwazVA5w=;
        b=fHBI8h2PhWHnA+TP7uCZgsGe3EZNg27AnstZ+gwuYK9HbgXvhK6Wa3taf6OuLvLyYu
         A5d2wt+EB3IHilC2ZqHSluzQseQjSvLApT/oa/VosPDkG1h8JmSv6zM0TYto6mdi7v7j
         hR3YOeZjyUXFzBAajgjIPn04czHTHSa3Y0IZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bJDvu/c+6pno/JSUhEAK98Vax7p/jqxUa/uO8upW6n1Hs9uVl1BnrpmsHk/tLK/Bkl
         rI894YT2reO/+hDMLBhTBpbBJr5K7uuiYxLFqMYut4ohaTprjJ29zmFfs+lzlF2g0TzC
         oCy0vAXZTm6qxhJ/zeQ5r54tLLPap74YGo9rU=
Received: by 10.86.27.19 with SMTP id a19mr741184fga.56.1213210090410;
        Wed, 11 Jun 2008 11:48:10 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Wed, 11 Jun 2008 11:48:10 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806111105150.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84638>

> So we don't want to smudge it, but if the stat information says it migth
> match even though it doesn't, we have to. But if the stat information says
> it matches, and the data actually _does_ match, then we shouldn't smudge
> it, we should be happy - and all subsequent users of the index will then
> know that they don't even need to look at the file contents.

I understand. In that case, what about an unsmudging routine so we can
have the best of both worlds? We unconditionally smudge the file as
soon as timestamp = mtime is detected. We never do index-wide smudging
on writes, but rather, on index read of particular file we do this:

  if (stats_differ()) {
    if (hash_matches()) {
      // Aha! An unconditionally smudged file that we might be able to unsmudge,
      // so future reads can avoid this check.
      if (mtime < timestamp) {
        fix_stats();  // Involves writing to index.
      }
      // D'oh! This file could still be racy, leave it smudged.
    } else {
      // The stats were right, the hash does differ.
      ...
    }
  }

We minimize the amount of ce_check_modified_fs() calls for any given
sequence of index operations. Instead of doing index-wide checks on
every write, we only check when we have no choice, i.e. the first time
a particular file is being looked up in the index. We fix its stats if
possible so future reads can avoid the painful check. The only
drawback is that I'm not sure how acceptable it is to write to the
index on a read operation. Is this a big deal? (If it were a separate
flag, I'm sure no one would mind!)

-Ben
