From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/32] Split index mode for very large indexes
Date: Tue, 29 Apr 2014 08:52:59 +0700
Message-ID: <CACsJy8B7P0Un0__9mS2j81PimPZbz9oTKZHKx8yo_smOMck1qA@mail.gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com> <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 03:53:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WexEk-0001Eo-QJ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 03:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbaD2Bxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 21:53:30 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:61149 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbaD2Bxa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 21:53:30 -0400
Received: by mail-qa0-f47.google.com with SMTP id j7so2918804qaq.20
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 18:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mwYDTMzZkqRoed2BBNqp+rbMmI+JBMhb3UyhWox877g=;
        b=mhDygdO3D120x5nAbzVY15UITIsxSN39+Pr7XBT6ewsetnDMfDW9v6ZV5hhOdPpV09
         /gRjHZ6ptr/09cq6T7Us8UnzuEB4JlAvqRGMwYCAfX80Uixpn4XCHZ2GdT2elGwLZ82r
         WJ2QSK/H9CeCLf2bHUuqErCAkRZtyPloohKdm68CtzwFYdPzM1wWbKWePCG44+2uHKR5
         gAnOOMpxbzpDYV+EUFIehZVrEeL505uWtfVddrNCCVLmKw1r4HyZsdcNzzkYlWSHkbC5
         11yE6m7TVPjcu2Ijs5GNGZf0aYcMy8DDriGwCfdiRX34JPaCrwt4vNeoreYCYXtrCIzD
         LekA==
X-Received: by 10.224.97.69 with SMTP id k5mr38720920qan.8.1398736409372; Mon,
 28 Apr 2014 18:53:29 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 28 Apr 2014 18:52:59 -0700 (PDT)
In-Reply-To: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247508>

On Tue, Apr 29, 2014 at 4:18 AM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Mon, Apr 28, 2014 at 3:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> I hinted about it earlier [1]. It now passes the test suite and with=
 a
>> design that I'm happy with (thanks to Junio for a suggestion about t=
he
>> rename problem).
>>
>> From the user point of view, this reduces the writable size of index
>> down to the number of updated files. For example my webkit index v4 =
is
>> 14MB. With a fresh split, I only have to update an index of 200KB.
>> Every file I touch will add about 80 bytes to that. As long as I don=
't
>> touch every single tracked file in my worktree, I should not pay
>> penalty for writing 14MB index file on every operation.
>
> This is a very welcome type of improvement.
>
> I am however concerned about the complexity of the format employed.
> Why do we need two EWAH bitmaps in the new index? Why isn't this just
> a pair of sorted files that are merge-joined at read, with records in
> $GIT_DIR/index taking priority over same-named records in
> $GIT_DIR/sharedindex.$SHA1?  Deletes could be marked with a bit or an
> "all zero" metadata record.

With the bitmaps, I know the exact position to replace or delete an
entry. Merge sort works, but I would need to walk through all entries
in both indexes to compare entry name and stage, a bit costly in my
opinion. And if you look at the format description in patch 0017, I
store the replaced entries without their names to save a bit more
space. "EWAH" is just an implementation detail. A straightforward
bitmap should work fine (25kb for 200k entries seem reasonable).
--=20
Duy
