From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] resolve_ref: close race condition for packed refs
Date: Mon, 13 May 2013 01:26:13 +0200
Message-ID: <51902515.7010500@alum.mit.edu>
References: <20130507023610.GA22053@sigill.intra.peff.net> <20130507023802.GA22940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 13 01:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubfeo-0002Au-NP
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 01:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab3ELX0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 19:26:18 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:46594 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038Ab3ELX0S (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 19:26:18 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-96-51902519101f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 97.AF.02380.91520915; Sun, 12 May 2013 19:26:17 -0400 (EDT)
Received: from [192.168.69.140] (p57A25404.dip0.t-ipconnect.de [87.162.84.4])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4CNQE1r006009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 12 May 2013 19:26:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130507023802.GA22940@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqCupOiHQYO4xQYuuK91MFg29V5gt
	5t3dxWTxo6WH2YHF49LL72wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3RvOTM+wF
	z/gq+pZ+YWpgPMDdxcjJISFgIvHk8xV2CFtM4sK99WxdjFwcQgKXGSVWNV1khnDOMkn8XrmY
	sYuRg4NXQFui44s7SAOLgKrExI8dLCA2m4CuxKKeZiYQW1QgTGLV+mXMIDavgKDEyZlPwGpE
	BGQlvh/eyAhiMwukS7xtewcWFxbwkvj/axZYr5BApsTKfx1sIDangLXE73eLmEDWMguoS6yf
	JwTRKi+x/e0c5gmMArOQbJiFUDULSdUCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZ
	JXqpKaWbGCGhzLeDsX29zCFGAQ5GJR7eBcoTAoVYE8uKK3MPMUpyMCmJ8t4BCfEl5adUZiQW
	Z8QXleakFh9ilOBgVhLhdWMAyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRl
	ODiUJHjlVIAaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFRGl8MjFOQFA/IXpB2
	3uKCxFygKETrKUZdjpVXnrxmFGLJy89LlRLnZQQpEgApyijNg1sBS1yvGMWBPhbmvaMEVMUD
	THpwk14BLWECWnLGox9kSUkiQkqqgbF17aL3nz721Bq/2KwgsoIxsfx+lrqm/KRJ6yd9C/z2
	OWpfphj3Fc/nh8LWpF2L8Oq6LF500muT97lwkVlHeBymxR3m/az1RVFLteFYwdK6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224070>

On 05/07/2013 04:38 AM, Jeff King wrote:
> [...]
> This patch solves it by factoring out the fallback code from
> the lstat() case and calling it from both places. We do not
> need to do the same thing for the symlink/readlink code
> path, even though it might receive ENOENT, too, because
> symlinks cannot be packed (so if it disappears after the
> lstat, it is truly being deleted).

To be really pedantic, we should handle all kinds of changes that
another process might make simultaneously:

* symlink -> deleted

  Was already OK, as you explained above.

* regular file -> deleted

  Handled by your patch

* symlink -> regular file

  Could come from

      update-ref --no-deref

  if the old version of the reference were a symlink-based symbolic
  reference.  Oops, wait, that's broken anyway:

      $ ln -sf master .git/refs/heads/foo
      $ git for-each-ref
      4204906e2ee75f9b7224860c40df712d112c004b commit	refs/heads/foo
      4204906e2ee75f9b7224860c40df712d112c004b commit	refs/heads/master
      $ git update-ref --no-deref refs/heads/foo master
      $ dir .git/refs/heads/foo
      lrwxrwxrwx 1 mhagger mhagger 6 May 13 01:07 .git/refs/heads/foo ->
master

  But supposing that were fixed and it occurred between the call to
  lstat() and the call to readlink(), then readlink() would fail with
  errno == EINVAL and we should respond by repeating the code starting
  with the lstat().

* regular file -> symlink

  Could come from overwriting a reference with a symlink-based symbolic
  reference.  But this could only happen if the parallel process were
  an old version of Git

I think it's been quite a while since Git has used symlinks for symbolic
references, so I doubt that it is worth fixing the second two cases.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
