From: Bryan Turner <bturner@atlassian.com>
Subject: Re: http-protocol question
Date: Tue, 2 Dec 2014 15:28:09 +1100
Message-ID: <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
	<20141202033416.GY6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 05:28:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvf4S-0008GA-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 05:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbaLBE2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 23:28:11 -0500
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36423 "HELO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752816AbaLBE2L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 23:28:11 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]) (using TLSv1) by na3sys009aob118.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVH0/2vGDGrFfYazf+NGKHcnJ9B3L0uhP@postini.com; Mon, 01 Dec 2014 20:28:11 PST
Received: by mail-ob0-f173.google.com with SMTP id uy5so9175708obc.4
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 20:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ewIQuPeUqRXr0S41UuuJvZcjfE9tt1emLfzt2PSqqMs=;
        b=cBR7fjykrW1wto+BsfbkjVtpX2RB79YXA0H5JpylKzfgxDcFQA7Xl3SIP1UJpBI+FZ
         OuQvYoAyh24EPtCkbz+NFslOapNEQ7dxKnL/ZFCqC6d08CT88DllRMRiTXlFOAs5I3mQ
         QM9lI/3J9fRebD/l6onIwQ2D++AfN62F7EDim+anPdyA6qWmvaRW0wRFE5A6PKVPKpzO
         bTZAmbfZykmgCNlr/JN00ZJG75+n3Q4zpHyXvTp8lCYZqps7X2N6iAXYwraWM4tUSeGc
         ehyTMQ2REc5g8Q7gRUCUdJOFzK/lPNTWJbrrG8i14IKB6shRVrSn6VpEG39iVkZEtpz7
         lceA==
X-Gm-Message-State: ALoCoQmMOeOe912BtZce5TX9mz3t/DSSVjmfb0DOOUWDWdsU1DaUHSPjWA8EZcj0G3CeKJSyjMFi/XfITCyxeL6FiU/quzN7LWMu0PEE5vRZVu6sVQGnhIlaH8mYGB9OrYj4yFgeuxdQ9/CIdk1tDBR0Zlk4qMUgUg==
X-Received: by 10.182.97.66 with SMTP id dy2mr6662973obb.30.1417494489911;
        Mon, 01 Dec 2014 20:28:09 -0800 (PST)
X-Received: by 10.182.97.66 with SMTP id dy2mr6662969obb.30.1417494489789;
 Mon, 01 Dec 2014 20:28:09 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Mon, 1 Dec 2014 20:28:09 -0800 (PST)
In-Reply-To: <20141202033416.GY6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260529>

On Tue, Dec 2, 2014 at 2:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Bryan,
>
> Bryan Turner wrote:
>
>> Is there actually logic somewhere in Git that does that "MAY walk
>> backwards" step?
>
> Yes.  See upload-pack.c::check_non_tip and
> http://thread.gmane.org/gmane.comp.version-control.git/178814.

Jonathan,

Thanks for the reply! I realize now I didn't really cite the part of
that documentation that I'm most interested in, which is: "through
history _or through the reflog_". It's the reflog bit I'm looking for.
Sorry for not being more clear. check_non_tip appears to look at
ancestry, walking back up (or down, depending on your view) the DAG to
see if the requested SHA-1 is reachable from a current ref, so it
looks like that's covering the "through history" part of that blurb.

The reason I ask is that there is a race condition that exists where
the ref advertisement lists refs/heads/foo at abc1234, and then foo is
deleted before the actual upload-pack request comes in. In that
situation, walking backwards through _history_ will only allow the
upload-pack to complete unless the deleted ref was merged into another
ref prior to being deleted (if I understand the code correctly). It
seems like looking at the reflogs, and seeing that refs/heads/foo did
in fact exist and did in fact refer to abc1234, is the only approach
that could allow the upload-pack to complete. The documentation hints
that such a thing is possible, but I don't see any code in Git that
seems to do that.

Does that make more sense? Does that functionality exist and I've just
overlooked it?

Thanks again,
Bryan Turner

>
> Hope that helps,
> Jonathan
