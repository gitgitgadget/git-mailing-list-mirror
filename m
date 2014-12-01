From: David Turner <dturner@twopensource.com>
Subject: Re: [RFC] On watchman support
Date: Mon, 01 Dec 2014 15:45:50 -0500
Organization: Twitter
Message-ID: <1417466750.20544.2.camel@leckie>
References: <20141111124901.GA6011@lanh> <1416270336.13653.23.camel@leckie>
	 <CACsJy8BfxP7KF1XF29BOgC6XhO8iAy-ycEoLkDG5rn6TYH_DrA@mail.gmail.com>
	 <1416334360.27401.10.camel@leckie>
	 <CACsJy8DayFy83JijrkgST5rAbNsst-dgqaP-ebpWXoGKPtp7sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 21:46:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvXr5-0003iF-0j
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 21:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbaLAUpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 15:45:55 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:55803 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbaLAUpy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 15:45:54 -0500
Received: by mail-qc0-f179.google.com with SMTP id c9so8179768qcz.24
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 12:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Et7F2KhtZ9BBxnB/04Pvw041x4gpA51uz9hPFl/W+zw=;
        b=Ttwe9bbtIC5qnrKBW6nEu0oeUIJzKbUh1eNMxBS+XnWu4j9fAFL0kLbrTG3zc336E6
         N1DSB8pASwbfE00x+OYY8tVej6t0WP5kfbPAYNiAEe0BjM6ZwK+/QT0ONax8D9FxPZGW
         7QoU10YWusxnbmHyTQmQkf4toR8M8Fzb2gYM+u3a8RBYY8+wHtojiDDH2pd6mAA83Rp/
         52q/Z1oDY4RMNpMEM7AazHLSb8rn10X4O/T115MbsjCYAcLustPUnK75s/R1mgUIwGa/
         ezJHMgrAPKVhc1nLuZM2M4xjod7RlTOdJqi0X7kRI3kHuA0PJVSTcnDOIsYPOfrDhTTe
         IPbA==
X-Gm-Message-State: ALoCoQkOgvZDrTUjr+IikLc8Zy+RdosUxSm+zFlQKdotqMjMlKvyz7asbM4H/H1JNNxpq7FwVtmb
X-Received: by 10.140.95.52 with SMTP id h49mr3617709qge.97.1417466753535;
        Mon, 01 Dec 2014 12:45:53 -0800 (PST)
Received: from [172.18.24.55] ([8.25.196.26])
        by mx.google.com with ESMTPSA id g66sm18317017qgf.37.2014.12.01.12.45.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Dec 2014 12:45:52 -0800 (PST)
In-Reply-To: <CACsJy8DayFy83JijrkgST5rAbNsst-dgqaP-ebpWXoGKPtp7sA@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260512>

On Fri, 2014-11-28 at 18:13 +0700, Duy Nguyen wrote:
> On Wed, Nov 19, 2014 at 1:12 AM, David Turner <dturner@twopensource.com> wrote:
> >> Or will you go
> >> with cityhash now.. I ask because you have another sse optimization
> >> for hashmap on your watchman branch and that could reduce init time
> >> for name-hash. Name-hash is used often on case-insensitive fs (less
> >> often on case-sensitive fs).
> >
> > Cityhash would be better, because it has actual engineering effort put
> > into it; what I did on my branch is a hack that happens to work
> > decently.  As the comment notes, I did not spend much effort on tuning
> > my implementation.  Also, Cityhash doesn't require SSE, so it's more
> > portable.
> 
> Cityhash looks less appealing to me. For one thing it's C++ so linking
> to C can't be done. I could add a few "extern "C"" to make it work.
> But if we plan to support it eventually, cityhash must support C out
> of the box.
> 
> Then cityhash does not support case-insensitive hashing. I had to make
> a CityHash32i version based on CityHash32. It's probably my bugs
> there, but performance is worse (~120ms) than original hashmap.c
> (90ms). Enabling sse4.2 helps a bit, but still worse. Using the
> case-sensitive version in place for memihash and strihash does make
> cityhash win over hashmap.c, around 50ms (with or without sse4.2). But
> that's still not as good as your version (~35ms)..

Can you post your CityHash32i?  

Have you tried this C port of Cityhash?

https://github.com/santeri-io/cityhash-c
