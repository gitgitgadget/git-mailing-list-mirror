From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Performance problem, long run of identical hashes
Date: Mon, 10 Dec 2007 10:07:50 -0500
Message-ID: <9e4733910712100707i66e185bofe22805b8e0ba4d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 16:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1kEv-00052E-Gd
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 16:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbXLJPHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 10:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbXLJPHv
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 10:07:51 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:38636 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbXLJPHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 10:07:51 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3398158wah
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=CKri+0Xz+vBzltklPSuv82yljIo76Uucu1W1kl2xajY=;
        b=ImmsBbQo9U3MisDdIxG7q+Gq8tIm9gq5Lyc35cQY32YWL42i+ue/P7R2yoZI9cD20zD+pUFPvS8mTuzk+nmianwLSr2OKAOmPefs2Qpyxqm5QvWHSU5vQcevyk0fMcFeiHCxteGCfX6E0FzWeKmPBvNpXi1/kSXM6SU30EWW8Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fORJ6y4Eiz8EWrqf7sx+nfCvuB1/s3XBpOO0SdJBectmYzdPigBbsgtJhgkpW6GbBOz6k0AV+QUDNIMaa1mIjiZKgHmFX23fmn7mgWvY71tSH+sWzMeRBw3Htqw7wKbARBmCcAioIP+VD92havZToi7GS2hM1gjPYAiehbkSXrE=
Received: by 10.114.75.1 with SMTP id x1mr4436443waa.1197299270293;
        Mon, 10 Dec 2007 07:07:50 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Mon, 10 Dec 2007 07:07:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67720>

Running oprofile during my gcc repack shows this loop as the hottest
place in the code by far. I added some debug printfs which show that I
have a 100,000+ run of identical hash entries. Processing the 100,000
entries also causes RAM consumption to explode.

create_delta()
	for (entry = index->hash[i]; entry < index->hash[i+1]; entry++) {
		const unsigned char *ref = entry->ptr;
		const unsigned char *src = data;
		unsigned int ref_size = ref_top - ref;
		if (entry->val != val)
			continue;
		if (ref_size > top - src)
			ref_size = top - src;
		if (ref_size <= msize)
			break;
		while (ref_size-- && *src++ == *ref)
			ref++;
		if (msize < ref - entry->ptr) {
			/* this is our best match so far */
			msize = ref - entry->ptr;
			moff = entry->ptr - ref_data;
			if (msize >= 4096) /* good enough */
				break;
		}
	}

-- 
Jon Smirl
jonsmirl@gmail.com
