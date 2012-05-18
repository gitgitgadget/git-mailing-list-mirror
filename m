From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] index-pack: use streaming interface on large blobs (most of the time)
Date: Fri, 18 May 2012 15:20:15 -0700
Message-ID: <xmqqzk95168w.fsf@junio.mtv.corp.google.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
	<1337172630-23679-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 00:20:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVVX6-0003Cs-TA
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 00:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239Ab2ERWUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 18:20:18 -0400
Received: from mail-gg0-f202.google.com ([209.85.161.202]:40186 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477Ab2ERWUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 18:20:16 -0400
Received: by ggeh3 with SMTP id h3so428341gge.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 15:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=uTxKZ4Fj8lbdVGgvXVaP2vRMOiYFgLBCFyFdxirpIik=;
        b=cHM0Y4X1Tknait40SPnDEnwzSfRKWNUoHZ7AmM45YKDdsxx5cHnulJ0JOh2GHkYmtX
         UnarwLywkCDeQeSQUi82INoT/7BZvs9YA06qUNUSdgTW9ycgcRqFnU3vHwWYqu/wKytN
         M5Rk9Mns4Bg/LLZtsj3K8EJ+AKVglQmcKEdMHVfhY/6TCGJ3ElmvTX6BEA7AGcZf6coq
         rF5HKe/V8z6J6NE2Ec75oFKTSMritWjvKhHAeCclnTuO7zVOyYSH7DzIqgdaDNmVVbPX
         yDlCa/AwE6SGqkQHj5t71RUP6w5WA4nEFBKkMqP9Vs6ecZTcECTl2V1R+9PdIyGMFF8J
         /HiA==
Received: by 10.100.246.30 with SMTP id t30mr2275099anh.17.1337379616086;
        Fri, 18 May 2012 15:20:16 -0700 (PDT)
Received: by 10.100.246.30 with SMTP id t30mr2275094anh.17.1337379616026;
        Fri, 18 May 2012 15:20:16 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id a57si8966565yhh.5.2012.05.18.15.20.16
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 15:20:16 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id E5DE21E004D;
	Fri, 18 May 2012 15:20:15 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 91E70E1772; Fri, 18 May 2012 15:20:15 -0700 (PDT)
In-Reply-To: <1337172630-23679-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 16
 May 2012 19:50:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQntK6m0U0W1wVeAV2W0g8vT90F7VAgOUOdXdzSdTZtQPmGszWw5K2cm4uprrkvB6JHh7Y9LeFaMJjjUw9WmvdahBVMig6LYcD+mZ7aTR9EzLmIfKJpg9aoXZgsEUWOoUuJYjNj7o4Ksm4ktQEHJu8m6Gsl7KA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197978>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> unpack_raw_entry() will not allocate and return decompressed blobs if
> they are larger than core.bigFileThreshold.
>
> The blob content is needed by sha1_object() in some cases. When we do
> need the blob content, we put it back in core with
> get_data_from_pack(). However we rarely need that in pratice.
>
> The first case is when we find an in-repo blob with the same SHA-1. W=
e
> need to do collision test, byte-on-byte. Normally (e.g. in
> fetch/pull/clone) this does not happen because git avoid to send
> objects that client already has.

Perhaps the codepath that performs the byte-for-byte comparison can be
taught to stream from the received pack data and whatever was already
in the repository, using the streaming interface?  That way you do not
have to hold all of the both objects at the same time in core, no?
