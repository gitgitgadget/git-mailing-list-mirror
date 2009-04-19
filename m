From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 08/12] send-email: Move Subject sanitization from 
	--compose code to send_message
Date: Sun, 19 Apr 2009 09:53:47 -0500
Message-ID: <b4087cc50904190753v6f5862c0sebe2dcc56c5269dc@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
	 <76718490904181854o380fe118y9f3a52c926bd1f6d@mail.gmail.com>
	 <b4087cc50904181937q38ef45fm7409e020ecf40792@mail.gmail.com>
	 <76718490904190713l3d6b5abcmf54544512de87413@mail.gmail.com>
	 <b4087cc50904190739u54a9a9d7p6f011ab2b47c1d05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 16:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvYQU-0002r4-MO
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 16:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760703AbZDSOxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 10:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760683AbZDSOxt
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 10:53:49 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:59034 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758457AbZDSOxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 10:53:48 -0400
Received: by qyk32 with SMTP id 32so999652qyk.33
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cJ4zp+ZmTv6f3AXyaewlicKwG/f8c3iAkIbmp5reRW0=;
        b=QWNCG7hvXVoE+Nzh2y3tRl8lgLlnSHCXkyzpncbXQssDPuSZYoDoXrZeO71RSa2IxB
         ZXEyADQrTJyaai95SMx6ZUZolaF3JGf/zvu1chcnpI8XcozIihN1PVn+uMQD4G4Ey1dl
         6Gp3ANbtT7fIktWGezC5s+oano6JUAqnxdw2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UkspeuSEzXG+BppK9hPoILvJ6W4Tlkr8tLw7M1zWGMAOf2RurkY5Ccc3KS5vt5OAmq
         9xCYZVcVOFyRF4A4l+4/UcA9qIzb62KawkPT0WlyDKKjqjDErpeWsSabGT6A64h9/Un9
         3a7X147QMU741HarnLfQvhLV4W06TIeIfk/dI=
Received: by 10.224.80.193 with SMTP id u1mr5420216qak.353.1240152827167; Sun, 
	19 Apr 2009 07:53:47 -0700 (PDT)
In-Reply-To: <b4087cc50904190739u54a9a9d7p6f011ab2b47c1d05@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116902>

On Sun, Apr 19, 2009 at 09:39, Michael Witten <mfwitten@gmail.com> wrote:
> I'm morally opposed to this kind of thing. The caller should be
> required to test whether quote_rfc2047() is required, as it's not the
> job of quote_rfc2047 to validate. Suppose that quote_rfc2047 were
> actually part of a library of useful functions that my program
> imports. Perhaps my program knows that it must always quote some piece
> of text. Why, then, should my program be forced to waste the cycles to
> perform a useless test?
>
> IMnsHO, verification should always be done by the caller with one
> exception: Interactive (human) input should always be verified,
> because humans represent an unreliable component in the system (in
> terms of digital systems, their asynchronous input must be
> synchronized with the clocked system). WIth this model, there's are
> fewer wasted cycles, because you can reuse verification across similar
> functions, and the code (particularly library code) is easier to
> understand.

I should add, though, that making the logic of the program clear is a
good idea. In that sense, your approach makes sense. Since we 'own'
quote_rfc2047(), I'd say we could take your approach, but rename the
function to something like quote_rfc2047_if_necessary(). If
quote_rfc2047() were part of a library, I think the only moral
solution would be to insist that callers wrap it in another function
named quote_rfc2047_if_necessary().
