From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Mon, 1 Apr 2013 23:19:42 -0600
Message-ID: <CAMP44s3yNGfW4aoHB90_D-OFrzchgvAugzdmOYHOey3wYkUxjg@mail.gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
	<1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
	<20130401233313.GB30935@sigill.intra.peff.net>
	<CAMP44s0uJ4ivNLw984CXWYk5HcKevuUJmpYOiyqbT1QJDaYd0Q@mail.gmail.com>
	<20130402023024.GB719@sigill.intra.peff.net>
	<CAMP44s2VcLUE=PHE=iSsgd67_ZV4N6b5Ya76Rc22xtSzK-Xz0g@mail.gmail.com>
	<20130402050154.GA21328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 07:20:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMtdl-0001iz-HN
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 07:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151Ab3DBFTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 01:19:45 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:58598 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab3DBFTo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 01:19:44 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so37501lab.33
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 22:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=QFefkFiO24p5ay7iMTqfRv8c5pu+IqR9fVHfb11OS1Y=;
        b=o8iDwvD7EH86Y1EoCGd02UpY7nfModOcDA7sY+dJqdpsXz4pAM5DgPgYEGZMUmkqq+
         68lsxK/5DpM5/7optNnRd7NnmOKDthi3+WFKPTHbpXvWUPg9wCATyDyPbF0+Qcpa8fC2
         bwbPp53HJyjR2SnLs3466ReKuS+PkIapjj5In1NyMhvtjqV17XCAQOcsctojnvhj1LAP
         fx0RfDRSiXtCMEWOdwlSO0x7cuyCOtV/YPc12YJfl8p60p06hzHrl19RxCxRsH5sT+du
         ay7dyLOSUQIbpUnEnap+VFG9LAZNwJVDlSQ59qT7Bn2Uyc3mNDBngS0oMg4AtI3E+3N8
         EZtg==
X-Received: by 10.152.145.134 with SMTP id su6mr7034209lab.35.1364879982800;
 Mon, 01 Apr 2013 22:19:42 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 22:19:42 -0700 (PDT)
In-Reply-To: <20130402050154.GA21328@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219738>

On Mon, Apr 1, 2013 at 11:01 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 01, 2013 at 10:51:20PM -0600, Felipe Contreras wrote:
>
>> > So in fetch_with_import, we have a remote-helper, and we have a
>> > bidirectional pipe to it. We then call get_importer, which starts
>> > fast-import, whose stdin is connected to the stdout of the remote
>> > helper. We tell the remote-helper to run the import, then we wait for
>> > fast-import to finish (and complain if it fails).
>> >
>> > Then what? We seem to do some more work, which I think is what causes
>> > the errors you see; but should we instead be reaping the helper at this
>> > point unconditionally? Its stdout has presumably been flushed out to
>> > fast-import; is there anything else for us to get from it besides its
>> > exit code?
>>
>> The problem is not with import, since fast-import would generally wait
>> properly for a 'done' status, the problem is with export.
>
> Your patch modified fetch_with_import. Are you saying that it isn't
> necessary to do so?

It's not, I added it for symmetry. But that's the case *if* the
remote-helper is properly using the "done" feature.

>> Also, the design is such that the remote-helper stays alive, even
>> after fast-export has finished.
>
> So if we expect to be able to communicate with the remote-helper after
> fast-export has exited, is it a protocol failure that the helper does
> not say "yes, I finished the export" or similar? If so, can we fix that?
>
> I am not too familiar with this protocol, but it looks like we read from
> helper->out right after closing the exporter, to get the ref statuses.
> Shouldn't we be detecting the error if the helper hangs up there?

I guess that should be possible, I'll give that a try.

Cheers.

-- 
Felipe Contreras
