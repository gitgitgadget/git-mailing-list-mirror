From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less aggressive
Date: Sun, 30 Dec 2007 20:06:25 +0100
Message-ID: <e5bfff550712301106l133dd38btd2cc4be02159387d@mail.gmail.com>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>
	 <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 20:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J93Uo-0001vW-6B
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 20:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbXL3TG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 14:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbXL3TG1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 14:06:27 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:7151 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbXL3TG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 14:06:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4275691rvb.1
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 11:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0FT3asS0hlJaZA/sDx8Ak0NY1QEkA/QrDvH4oH7i6lo=;
        b=xrcEhQzfN+Fp0yNOEq7wrFQNDUpB+S2f3ztE953y7Bvmo7gPW1EehDm8bQj5Xl/au4Mjkd39yvAJMbX5Jc+8gfjH63qhF1tnN/B8Njy8woJuPfDB0cZHYtc8y2vnWzFzr1z+Pp2zfsoFtBOuJvkc0azJ5DxsvAfLacshws4o72Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j6+UDV5N14MyT0Ebt7j6Y2xCiq4cRehkH6QVkinAHKwybDqBzf1gkEyNh5sV6cGlBu14JSsn7Q6/6ZieRSYJjYgf85PPijM3JeTVLFsk3F1gcjOMiGFjmjJojnd3a8X6hpaJBFeeOfC2Xp3YI9iUVxlA5ougwmADqNtfo93KTLo=
Received: by 10.141.28.12 with SMTP id f12mr5975795rvj.1.1199041585366;
        Sun, 30 Dec 2007 11:06:25 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 30 Dec 2007 11:06:25 -0800 (PST)
In-Reply-To: <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69376>

On Dec 30, 2007 12:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> With this patch, we actually see slight improvements in
> execution time as well.

I have applied both your patch above and what we have discussed today,
the patch to speedup prefixcmp() and mine experimental one to avoid a
lookup loop in strbuf_expand().

I don't see big differences with or without you patch applied.

Just for document the profiling I have uploaded a snapshot of
KCachegrind profiling data on a run of git-log on the git tree:

http://digilander.libero.it/mcostalba/callgrind_git_log1.png

>From there you can see that pretty.c and strbuf.c, after all the
optimizations, account for less then 8% of total time.
The biggest part is that 86.64% that is due almost entirely to zlib.

In particular

st = inflate(&stream, Z_FINISH);

called from unpack_compressed_entry() in sha1_file.c accounts for 72%
of total time.


Marco
