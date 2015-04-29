From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 14:30:59 -0700
Organization: Twitter
Message-ID: <1430343059.14907.18.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
	 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:31:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZZf-0007OY-Ds
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbbD2VbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:31:07 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34029 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbD2VbD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:31:03 -0400
Received: by pdbqa5 with SMTP id qa5so39678987pdb.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 14:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=76bmv05o/8jkno2lNERW4Esd4/0y5IGXDbvTWMvKgE0=;
        b=TQqOTFUPwzjl/dDjVLpy0bMCW+5uYMRy23mKNkVcQsKdgjTGdjgoueVmcN0ZBZ99Hz
         AjABJFGfRod+74iw3b3jutU/T19HJCge+6j0an03XTL1vueaJZ7n5jmq2e8tp8SoiQmy
         HXQJ7uWjdKxHsNSr5tQb+p5S849IRDob1Jjrs5QulNIbsk4eCdw4bB6E+tGRDpYj2e+R
         SCOxTuGNUdpBAXrhc+KNcyDLTUVsR+hw/E/STr7o5g0dRvyzOKe96IJOlbSWPJBYP229
         8LmmHWOoGWlq3Rx893yXfHSqcyANm3LB4oM4OvdyeVIwTMdv2bYXJpnFzKKUrgDO+pci
         VWKw==
X-Gm-Message-State: ALoCoQmGvI0jHcOPXxG4Zt1q7U6BxwXSy12roLyK4ii2Ddq6i2g7Nr6z+SncXw/pA+pYvTmAqsxw
X-Received: by 10.70.38.33 with SMTP id d1mr1886528pdk.99.1430343062166;
        Wed, 29 Apr 2015 14:31:02 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id mp3sm151557pbc.8.2015.04.29.14.31.00
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 14:31:00 -0700 (PDT)
In-Reply-To: <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268026>

On Wed, 2015-04-29 at 14:17 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Do people think this is reasonable?
> 
> I personally don't, exactly because we track the contents of the
> symlink itself, not the referent.  Your "major wrinkle" that they
> can point outside the repository is a mere manifestation of that.

I'm not sure I understand why tracking the contents of the symlink is a
problem for this approach.  It seems reasonable to ask what would have
happened had I checked out the repo at a certain SHA and said "cat
foo/bar/baz".

> The format specifiers the --batch option takes do not exactly give
> you what the in-tree type of the thing is, to allow the receiving
> end that parses the tagline (which it needs to do anyway in order to
> find out where the current record ends) act on it.  %(objecttype)
> would just say "blob" and you cannot tell if it is a plain file,
> executable or a symbolic link.
> 
> Perhaps an ideal interface might be something like this:
> 
>     $ echo HEAD:RelNotes |
>       git cat-file --batch='%(objecttype) %(intreemode) %(objectsize)'
>     blob 160000 32
>     Documentation/RelNotes/2.4.0.txt
> 
> I suspect it would be just the matter of teaching "cat-file --batch"
> to read from get_sha1_with_context() in batch_one_object(), instead
> of reading from get_sha1() which it currently does.
> 
> And that inteferface I think I can live with.

Even if I had %(intreemode), I would still have to do a recursive search
to figure out whether Documentation or RelNotes was a symlink.  This is
why I want a follow-symlinks mode.  And since I am already reading
RelNotes, I can (and presently do) parse the mode out of that data.
$(intreedmode) would save me some parsing, but it would not save me any
reading, nor would it make my code any less complex.  But
--follow-symlinks would simplify my code.
