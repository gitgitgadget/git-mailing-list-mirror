From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating
 an mbox.
Date: Tue, 08 Jun 2010 22:48:44 -0700
Message-ID: <4C0F2B3C.4060203@zytor.com>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org> <7vljaorhjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 07:50:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMEBF-0000nj-FW
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 07:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab0FIFuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 01:50:05 -0400
Received: from terminus.zytor.com ([198.137.202.10]:51997 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab0FIFuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 01:50:04 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by mail.zytor.com (8.14.4/8.14.3) with ESMTP id o595mkH0018796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Jun 2010 22:48:46 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.4/8.14.3) with ESMTP id o595mjHj015850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 8 Jun 2010 22:48:45 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.4/8.13.6) with ESMTP id o595mihI027995;
	Tue, 8 Jun 2010 22:48:44 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Thunderbird/3.0.4
In-Reply-To: <7vljaorhjq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148741>

On 06/08/2010 08:50 PM, Junio C Hamano wrote:
> Carl Worth <cworth@cworth.org> writes:
> 
>> Without this patch series, there's no documented way that an external
>> tool can use to reliably construct an mbox that will be correctly handled
>> by "git am". The best one could do is to peek inside the git implementation
>> and notice that it wants unescaped "From " lines, that it will ignore any
>> "From " line that doesn't end with something very much like asctime format,
>> and then somehow ensure that no messages in the mbox have lines that begin
>> with "From " and end with something like asctime format, (which won't be
>> possible in all cases without corrupting the message).
> 
> I have this small suspicion that mboxrd may be a suboptimal choice, when
> you consider how robustly we can notice a failure (and to a lessor extent,
> recover from it) when using output from "format-patch --stdout" to
> sneakernet between existing and updated versions of git.  Especially
> because your implementation quotes lines that begin with "From "
> unconditionally (even when the tail end of the line would never be a
> valid-looking timestamp).  Such an output will confuse existing mailsplit,
> but the worst part of the story is that somebody who is applying a series
> of patches will _not_ notice the breakage.  The payload of the second and
> subsequent messages will likely be concatenated as if it were part of the
> first message, ignoring cruft between patches, but the resulting tree
> would likely to be the same as what the sending end intended.
> 
> Compared to that, I think a failure to split a message in the middle (iow,
> commit message happened to have a line that begins with "From " and ends
> with a timestamp-looking string) is much easier to notice (because the
> first part of the message that was incorrectly split at such a line will
> not have any patch, so "git am" will stop).  IOW, failure to split is
> easier to notice than splitting too eagerly.
> 
> Perhaps perfect is an enemy of good?

For production perhaps we should do the MIME-escape thing?

For consumption, it's not so clear...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
