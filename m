From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Fix start_command() pipe bug when stdin is closed.
Date: Mon, 25 Aug 2008 13:49:38 +0200
Message-ID: <48B29C52.8040901@gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 13:50:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXaat-0003r5-Gf
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 13:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbYHYLtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 07:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbYHYLtn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 07:49:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:57000 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbYHYLtm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 07:49:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so953717fgg.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=IashY2gxZO1Iqw6wsezH34Ejd35xhi+ndcwMUPlcU9k=;
        b=ckInpyABKJ/VUdaVUfmyq+OJnWexTbeeXoEkRJcOzPK3RJfLdxcp+NzvhHRa10sV0x
         z+n4pd7LKKwCThjfLhup1Mw5Wi9/PIX1C61/r10C6vMvyRw9S9BDR3BlOsvrvPPTpTn5
         LgqH05Gm51nCZ1lyWb3zXogTHaLkvZmBMsJjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=QUR/aw5CL3MviqJyYVSzwQDJ84SYiNyLlpY9+vS6bPPNkTiSVeL2fGchBjgrQHh8Rf
         MzoaXbY141BCJT/VmtpkNVlzf5u0q++BztZ2/FoxwHJW7DTPK9Igf3jUcnFIfKxTWkJx
         olweDuTADppnpts6QKUMKCGPiemGgeAwkNjhs=
Received: by 10.86.74.15 with SMTP id w15mr3272447fga.42.1219664981069;
        Mon, 25 Aug 2008 04:49:41 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id 4sm1145329fge.8.2008.08.25.04.49.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 04:49:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <48B28CF8.2060306@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93613>


> While I do see that there is a problem, it is only half of the story, and
> your patch addresses only this half.
> 
> What if stdout is closed, too? Then the ends of the first allocated pipe
> would go to fds 0 and  1, and then the pipe end at 1 would be closed by a
> subsequent dup2(xxx, 1).

What about opening files (in start_command, protected by a loop that run
only once, or on startup) until you get a descriptor that is > 2?  Like
this:

  static int low_fds_reserved;
  if (!low_fds_reserved)
    {
      int fd = open("/dev/null", O_RDWR);
      while (fd >= 0 && fd <= 2)
        fd = dup (fd);
      if (fd != -1)
        close (fd);
      else
        perror ("start_command");
      low_fds_reserved = 1;
    }

Paolo
