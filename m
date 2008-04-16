From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 00:07:27 +0100
Message-ID: <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
	 <20080416200107.GG3133@dpotapov.dyndns.org>
	 <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com>
	 <20080416203923.GH3133@dpotapov.dyndns.org>
	 <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com>
	 <20080416223739.GJ3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Dmitry Potapov" <dpotapov@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 01:08:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmGjo-0002af-C2
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 01:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbYDPXHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 19:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbYDPXHa
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 19:07:30 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:62525 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbYDPXH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 19:07:29 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3029133fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 16:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=61cPqFHzbJrNmKCJ+t2P4LvwNhTIokLB01XtwLHfp3M=;
        b=X3UuFc3OR8fvm+V6M2zF9uRJD0FxCaSmr+mBZxDPhF49G7LM9WDZGdgAH+NMbmUJAt1MsPE/ukL85omp2mBRAHaKpUcAKtO6JD51Qy/5wZDNEBf89XQRFUv1TJQ703L6FiPDdk0b54IXbL4+u1fLButZht8K/2g87TFDcGIdt9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ug+Frxl/ek3ZaxJUWfhVDnaF5JEaF1Hzyb9ls+Zvxpr9KaL/EFqWD2PigMlE/0cicvKQxbjAElhsnydv1uhLU04RCNdtfzTrZhv/zeDfWi8XPHKgDZUlSiHpUwuXPaEW8u+hVjlGcGSFyjwLbM0Qs8T76mWSjYNgVzzlk8xLbxg=
Received: by 10.82.150.20 with SMTP id x20mr906813bud.85.1208387247932;
        Wed, 16 Apr 2008 16:07:27 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Wed, 16 Apr 2008 16:07:27 -0700 (PDT)
In-Reply-To: <20080416223739.GJ3133@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79761>

>  > The bit I really don't understand is why git thinks a file that has
>  > just been touched has chnaged when it hasn't,
>
>  Actually, it did change in the sense that if you try to commit this
>  file now into the repository, you will have a different file in Git!
>  So, it is more correct to say that Git did not notice this change until
>  you touch this file, because this change is indirect (autocrlf causes
>  a different interpretation of the file).
>

Okay - at the very least this behaviour is really, really confusing.
And I think there's actually a bug (it should *always* report that the
file is different), not magically after it's been touched.

But fixing that minor bug still leads to badness for the user. Doing
(on a core.autocrlf=true machine) a checkout of any revision
containing a file that is (currently) CRLF in the repository, and your
WC is *immediately* dirty. However technically correct that is, it
doesn't fit most people's user model of an SCM, because they haven't
made any modification. And if 1 person makes a change along with their
conversion, and the other 'just' does a CRLF->LF conversion, their
revisions will conflict at merge time. Blech. And because the svn is
mastered crlf (well, strictly speaking, it's ignorant of line endings)
this is gonna happen a lot.

Can't git be taught that if the WC is byte-identical to the revision
in the repository (regardless of autocrlf) then that ought not to be
regarded as a change?
Is there a way I can persuade the diff / merge mechanisms to normalise
before they operate? (e.g if core.autocrlf does lf->crlf/crlf->lf,
then an equivalent that does crlf->lf/crlf->lf before doing the merge
)?

In a perfect world I'd be able to switch all files int he repo to LF,
but that's not going to happen any time soon because of the majority
of developers, still on svn, still on windows.
