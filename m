From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 09/23] pack v4: commit object encoding
Date: Tue, 3 Sep 2013 14:41:01 +0700
Message-ID: <CACsJy8B0XGAoxYBNoaYt5PP=kA3dfgFpdnMj8DCCX65UeOJ=ug@mail.gmail.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-10-git-send-email-nico@fluxnic.net> <CACsJy8CnSyw2ae5BS87S8Hid51JVFB3gyLzX+5czwio+C=-VRQ@mail.gmail.com>
 <alpine.LFD.2.03.1309030225450.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:41:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGlFB-0004re-KC
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517Ab3ICHle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:41:34 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:53691 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932460Ab3ICHlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:41:32 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so6175702oag.21
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 00:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b8qYqlg1uqgVKMKlx5vwq+Ab+nOoUzzSTaEu1uh0Z8U=;
        b=Y2+3UgmSan72l/RaxJ9DXKRoNA5wlvSrPZnuP1HpzUvSk9D8D9W8Fg6uYVIkhGfUgp
         ZlZA9bo44eMg+eRwal9xlk4GQ7xCmiuUQvFRk05/f5flWlwWo7GZcxqjrkaqdiU3aeqH
         dBbrS4AD+P0XdBBSrSdyOTBWjLNGmvXd0hXOQenB5H3eeY/Ir3G57HDdVW/jJspp5UXO
         s0cGTz5LfDE9sFYkbA8HqMFp3geLoQCTXj9hqwoTk4bCZc52NeQk1vn4iHzbYxCOKL+4
         mnicG7hQWNME+b9ERuq3k2IkJaVomAw8ff8Ih4wVBdzLPv/nECQOMM76ky9qrVyzaTLP
         yguQ==
X-Received: by 10.60.44.240 with SMTP id h16mr19736003oem.2.1378194091809;
 Tue, 03 Sep 2013 00:41:31 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 3 Sep 2013 00:41:01 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309030225450.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233702>

On Tue, Sep 3, 2013 at 1:30 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 3 Sep 2013, Duy Nguyen wrote:
>
>> On Tue, Aug 27, 2013 at 11:25 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > This goes as follows:
>> >
>> > - Tree reference: either variable length encoding of the index
>> >   into the SHA1 table or the literal SHA1 prefixed by 0 (see
>> >   add_sha1_ref()).
>> >
>> > - Parent count: variable length encoding of the number of parents.
>> >   This is normally going to occupy a single byte but doesn't have to.
>> >
>> > - List of parent references: a list of add_sha1_ref() encoded references,
>> >   or nothing if the parent count was zero.
>>
>> With .pack v3 it's impossible to create delta cycles (3b910d0 add
>> tests for indexing packs with delta cycles - 2013-08-23) but it is
>> possible with .pack v4 (and therefore at least index-pack needs to
>> detect and reject them), correct? Some malicious user can create
>> commit A with parent ref 1, then make the SHA-1 table so that ref 1 is
>> A. The same with the new tree representation.
>
> pack-index should validate the SHA1 of the object being pointed at.
>
> In that case I doubt you'll be able to actually construct an object
> which contains a SHA1 parent reference and make the SHA1 of this very
> object resolve to the same value.

We could do that for commits. For trees, we need to look at the base's
content to construct the current tree and cycles could happen. I think
we could make a rule that base trees must appear in the pack before
the tree being constructed (similar to delta-ofs). The exception is
objects appended for fixing thin pack.
-- 
Duy
