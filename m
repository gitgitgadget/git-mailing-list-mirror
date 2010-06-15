From: bonneta <bonneta@ensimag.fr>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Tue, 15 Jun 2010 14:13:58 +0200
Message-ID: <d15348c8322f5f99aa1f330d32e0ddd4@ensimag.fr>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr> <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr> <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr> <7vfx0p9wlm.fsf@alter.siamese.dyndns.org> <0091febb4a3832a6680a0fbc2209f841@ensimag.fr> <20100615095452.GA32624@sigill.intra.peff.net> <aad13a73928536f87879ef7284d6cc75@ensimag.fr> <20100615110710.GA1682@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 15 14:14:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOV21-0002GH-R0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 14:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab0FOMOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 08:14:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34774 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab0FOMOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 08:14:09 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5FC5unO015006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 14:05:56 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5FCDx4Y021060;
	Tue, 15 Jun 2010 14:13:59 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o5FCDw0l025523;
	Tue, 15 Jun 2010 14:13:59 +0200
In-Reply-To: <20100615110710.GA1682@sigill.intra.peff.net>
X-Sender: bonneta@ensimag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 15 Jun 2010 14:05:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FC5unO015006
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: bonneta@ensimag.fr
MailScanner-NULL-Check: 1277208360.24699@PHypNMZjTU30fUsIMlTEyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149172>

On Tue, 15 Jun 2010 07:07:10 -0400, Jeff King <peff@peff.net> wrote:
> [resending to cc git@vger]
> 
> On Tue, Jun 15, 2010 at 12:29:43PM +0200, bonneta wrote:
> 
>> We have changed the declaration of textconv_object() to:
>> 
>> static int textconv_object(const char *path,
>>                            const unsigned char *sha1,
>>                            char **buf,
>>                            unsigned long *buf_size)
>> 
>> And now we can do:
>> *buf_size = fill_textconv(textconv, df, buf);
>> without any cast.
> 
> I assume you mean dropping the final buf_size parameter from that
> declaration, which is what your usage example has. I would return either
> an "unsigned long" or a size_t rather than an int. We are dealing with
> potential whole-file sizes, so it is better to use at least as large a
> data type as other parts of the code (we still may run into truncation
> problems, but at least you are not making things any worse).
> 
>> But we have to do:
>> textconv_object(read_from, null_sha1, &buf.buf, (unsigned long *)
>> &buf.len))
>> where buf.len is size_t.
>> 
>> Is that ok?
> 
> No, that has the same problem. Imagine a big endian machine with a
> 32-bit unsigned long and a 64-bit size_t. You would write into the first
> 32 bits of buf.len, which are the high bits, giving you a ridiculously
> large answer.
> 
> The only portable way in C to convert between types is by assignment. So
> you have to do:
> 
>   unsigned long foo;
>   textconv_object(read_from, null_sha1, &buf.buf, &foo);
>   buf.len = foo;
> 
> But now I'm confused. That matches the declaration you gave in the first
> part of your email, but not the usage example.

We now understand what we have to do, thank you.
We are currently fixing this patch.
Do we have to resend only this patch or the whole series?
