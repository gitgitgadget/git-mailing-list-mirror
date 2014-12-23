From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 16:24:57 +0100
Message-ID: <54998949.9090908@web.de>
References: <20141223084536.GA25190@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 16:25:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3RL1-0004Zd-BW
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 16:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181AbaLWPZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 10:25:26 -0500
Received: from mout.web.de ([212.227.15.14]:65504 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbaLWPZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 10:25:25 -0500
Received: from macce.local ([93.222.20.216]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MI5yY-1Y2t652FrC-003rjs; Tue, 23 Dec 2014 16:25:00
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141223084536.GA25190@peff.net>
X-Provags-ID: V03:K0:nxbccBBXQBIANK0hXj089rxCvO3d3DVFpPsQVTO0Iy+Zukl2mw2
 iteSr7x0yg8inqmV6f1AVOoEO3EoSreHqXmQcOMafwTfjGajeAe8goXIYxdvzvBogmqGgNR
 ZofTjS4uqZO8Ylum6NDMlQJTTshJr5WZ3sFbhNy/DZyfoHwZBkV3fLVK+8vlUv7BwuhCzmS
 wnx70UV66wepet+OjuoCw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261734>

On 2014-12-23 09.45, Jeff King wrote:
> Our is_hfs_dotgit function relies on the hackily-implemented
> next_hfs_char to give us the next character that an HFS+
> filename comparison would look at. It's hacky because it
> doesn't implement the full case-folding table of HFS+; it
> gives us just enough to see if the path matches ".git".
> 
> At the end of next_hfs_char, we use tolower() to convert our
> 32-bit code point to lowercase. Our tolower() implementation
> only takes an 8-bit char, though; it throws away the upper
> 24 bits. This means we can't have any false negatives for
> is_hfs_dotgit. We only care about matching 7-bit ASCII
> characters in ".git", and we will correctly process 'G' or
> 'g'.
> 
> However, we _can_ have false positives. Because we throw
> away the upper bits, code point \u{0147} (for example) will
> look like 'G' and get downcased to 'g'. It's not known
> whether a sequence of code points whose truncation ends up
> as ".git" is meaningful in any language, but it does not
> hurt to be more accurate here. We can just pass out the full
> 32-bit code point, and compare it manually to the upper and
> lowercase characters we care about.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I saw Linus ask about this on G+. I had done the "no false
> negative" analysis when writing the patch, but didn't
> consider the false positive.
> 
> Another way of accomplishing the same thing is for next_hfs_char to
> continue folding case, but _only_ do so for 8-bit code points. Like:
> 
Don't we have the same possible problem under NTFS?
Under Linux + VFAT ?
Under all OS + VFAT ?


And would it make sense to turn this
>   return (out & 0xffffff00) ? out : tolower(out);
into this:
static ucs_char_t unicode_tolower(ucs_char_t ch) {
   return (ch & 0xffffff00) ? ch : tolower(ch);
}


And what happens if I export NTFS to Mac OS X?
(Other combinations possible)
Shouldn't fsck under all OS warn for NTFS and hfs possible attacks ?
 
