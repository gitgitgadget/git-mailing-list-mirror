From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 04/10] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Tue, 22 Jan 2013 00:27:01 -0800
Message-ID: <20130122082701.GE6085@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-5-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:27:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxZCc-00041o-Fw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab3AVI1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 03:27:08 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:48528 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab3AVI1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:27:07 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so3932873pad.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 00:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/ni8Riuoa/z1L26vUiRiARzeXtLlojQDCEv3R5Bzckg=;
        b=sEfKmPuUAGIbyfdi47vbx7Kfx48A/u/ctueXi7DuMX9Km99wCXm1agOD7jjY2ZLS+n
         Lz8ZbtMEG+ELunV0bvVb+oTBlyuE1bJyzXaC8Snw6D3BnuKTp9boxuKsuJFuqlyClblZ
         9iaS9FVid0g1ND8sxnPWPiXlxa2tbCe+8sDfUJO5jrri8mf24HRPZFkJx5y5s8gB6/ED
         WBR4k9mkUqqHvM00PZmYbHO6qoKZ3IulTa6aAWR8DaWBi4ii+id0Scmsz8um0u0BM9DL
         PwNUdpapTNoRiwBvNnLU1UtfntLbOzzHdzws2a9XFrft+8n3sg+4ZWoA0fz/rNOUqJ1v
         rj3w==
X-Received: by 10.66.77.201 with SMTP id u9mr54129460paw.80.1358843226917;
        Tue, 22 Jan 2013 00:27:06 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ni8sm10318868pbc.70.2013.01.22.00.27.04
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 00:27:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358757627-16682-5-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214217>

Brandon Casey wrote:

> Let's detect "(cherry picked from...)" as part of the footer so that we
> will produce this:
>
>    Signed-off-by: A U Thor <author@example.com>
>    (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
>    Signed-off-by: C O Mmitter <committer@example.com>
>
> instead of this:
>
>    Signed-off-by: A U Thor <author@example.com>
>    (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
>
>    Signed-off-by: C O Mmitter <committer@example.com>

Yes, looks sane.

A downside is that this produces an arguably worse result when using
"-x -s" for a commit that does not already have a sign-off.  Before,
we had:

	test: do something great

	Do something fantastic in a clean and elegant way that
	only takes two lines of explanation.
	(cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)

	Signed-off-by: C H Errypicker <cherry-picker@example.com>

Afterwards, we will have:

	test: do something great

	Do something fantastic in a clean and elegant way that
	only takes two lines of explanation.
	(cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
	Signed-off-by: C H Errypicker <cherry-picker@example.com>

An ideal result would be completely different:

	test: do something great

	commit da39a3ee5e6b4b0d3255bfef95601890afd80709 upstream.

	Do something fantastic in a clean and elegant way that
	only takes two lines of explanation.

	Signed-off-by: C H Errypicker <cherry-picker@example.com>

In other words, the -x output format that puts the commit id at the
end with odd spacing seems to be of questionable taste anyway.  But
given the constraint of leaving that alone, cramming together the
sign-off like this seems like the best we can do, so for what it's
worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
