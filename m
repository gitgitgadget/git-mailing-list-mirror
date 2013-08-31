From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/8] Multiple simultaneously locked ref updates
Date: Sat, 31 Aug 2013 21:02:46 +0200
Message-ID: <52223DD6.3070303@alum.mit.edu>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:03:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqRn-0004YQ-7M
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab3HaTC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:02:56 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60574 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755936Ab3HaTCv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 15:02:51 -0400
X-AuditID: 1207440d-b7f006d000000adf-11-52223ddaa365
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E4.DF.02783.ADD32225; Sat, 31 Aug 2013 15:02:50 -0400 (EDT)
Received: from [192.168.69.9] (p57A2512F.dip0.t-ipconnect.de [87.162.81.47])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7VJ2lwR003316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 31 Aug 2013 15:02:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <cover.1377885441.git.brad.king@kitware.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqHvLVinIYF63osXOdRIWXVe6mSwa
	eq8wW9x/v47JgcXjcl8vk8fHZ8vZPS5eUvb4vEkugCWK2yYpsaQsODM9T98ugTvj6DnNgj6p
	it2ffBsYZ4p0MXJySAiYSJye+o0NwhaTuHBvPZgtJHCZUeLTbIEuRi4g+wyTxNlLL9lBErwC
	2hJn/05k7mLk4GARUJV4ttAbJMwmoCuxqKeZCcQWFQiT2DF9IhtEuaDEyZlPWEBsEaDyVesa
	wOLMAhkSqz7cAasXFnCT6HvdxgyxN1XiW087WA2ngKXElMZ7zBD1OhLv+h5A2fIS29/OYZ7A
	KDALyYpZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkjHl3
	MP5fJ3OIUYCDUYmHN2GpQpAQa2JZcWXuIUZJDiYlUd4iG6UgIb6k/JTKjMTijPii0pzU4kOM
	EhzMSiK8p1cqBgnxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4L4AM
	FSxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFaHwxMEpBUjxAexmByUKIt7ggMRco
	CtF6ilGX413TvE+MQix5+XmpUuK8LNZARQIgRRmleXArYEnrFaM40MfCEKN4gAkPbtIroCVM
	QEuuTQR5rrgkESEl1cDY8nvblevFf1N/T6yL3HLHIlr0aMJaCbu3USuqimKDxK9pLvE139e+
	emGVlEZjVObSV7EbLztsrJnLGtvkvrL1ybSoJr/MCX8en5G47/Xi+Da3Dv8PzvVf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233530>

On 08/30/2013 08:11 PM, Brad King wrote:
> Here is the second revision of a series to support locking multiple
> refs at the same time to update all of them consistently.  The first
> series can be found at $gmane/233260.  This revision is ready to
> consider for integration.

I'm very interested in this area and I regret that I have been so
invisible lately.  I definitely like the way your changes are going.

I have been doing some work in the same neighborhood and our work
overlaps somewhat.  Namely, it is incorrect that delete_ref() currently
deletes the loose ref before rewriting packed-refs, because it can cause
a simultaneous reader to see the packed value for a moment in time, and
the packed value might not even point to a valid object anymore.  In
fact, the current version is even worse: it deletes the loose reference
before even locking the packed-refs file, so if the packed refs file
cannot be rewritten (e.g., because it is locked by another process) then
the reference is permanently left in a corrupt state.

On the other hand, writing the packed-refs file first would also be
incorrect, because a pack-refs process could jump in before the loose
refs file was deleted, read the loose value, and write it to the new
packed-refs file.  The result would be that the first process would
think that it had deleted the reference but it would still exist (not
such a catastrophe, but incorrect nevertheless).

The solution that I have been working on is to first lock *both* the
loose and packed refs files, then rewrite the packed-refs file *but
retain a lock on it*, then rewrite the loose-ref file and release its
lock, then release the lock on the packed-refs file.  By retaining the
lock on the packed-refs file during the whole "transaction", we prevent
another process from trying to pack the refs before our reference is
completely deleted.  This requires the file-locking API to be enhanced
to allow a file to be replaced by its new version while still retaining
a lock on the file.

Your code has the same bug as the original (it's not your fault!) so I
think it will eventually have to be fixed to look something like

    acquire lock on packed-refs

    for reference in ref_updates:
        lock reference
        if old sha1 known:
            verify old sha1 is still current

    for reference in ref_updates:
        if reference should be created/modified:
            modify reference
            release lock on reference

    delete references from packed-refs file and activate new
            version of the file *but retain a lock on the
            packed-refs file*
    for reference in ref_updates:
        if reference should be deleted:
            delete loose version of reference
            release lock on reference

    release lock on packed-refs file

This is really all just for your information; there is certainly no
obligation for you to fix this pre-existing problem.  And I'm working on
it anyway; if you happen to be interested you can view my current
work-in-progress on GitHub (though it still doesn't work!):

    https://github.com/mhagger/git/tree/WIP-delete-ref-locking

Feedback would of course be welcome.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
