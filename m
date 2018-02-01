Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF761F404
	for <e@80x24.org>; Thu,  1 Feb 2018 23:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeBAXKt (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 18:10:49 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:41104 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeBAXKs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 18:10:48 -0500
Received: by mail-pg0-f54.google.com with SMTP id 141so2534501pgd.8
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 15:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackthorn-media.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=cYuKlfW/r+MrcVtIEA3XpX8P3qSD3r42sHeg34Q2TRQ=;
        b=UCi9jW3UQu0JfxY0dtkIKHCVnq5IpkpZkHNDCQRIg641e0kW/9zQBw0AYVj7dKE0Le
         c0+GyH/ofqi7FW21HTU0WqGhAX1MhX6cvv7uQ+STwLDp+Z3ZJZ6Nm3227BQNUydKKzXg
         W/gBcVHN8ZuYzBZ3COCxuCg+HV48v7V63ZJ5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=cYuKlfW/r+MrcVtIEA3XpX8P3qSD3r42sHeg34Q2TRQ=;
        b=DO6SHi9v+SctrTucJDr5QCNW3DM6Uw2XH8U+rN+9TLUTfvB9g/Qb8Ynk4t+cpz/ZyE
         tl2ppIri0W+GNql6c/scwuI4QsW8A1DvQn5HQ2hECzdZbVnvFrGtYE/oSTvkvMH2AjwM
         rh1za5riu8hDkxmG2eBeaayko7jbtSD8YHF8qnhvKrhyq9aOZkK3j5KYWY/bbQeVKKbD
         E7m9p+zaIMVlE8TzDN7witBgVYf32pyK6ytGxMBqw2YmtK25ngS77iqED+yxkgqfqVbF
         p/uGX+c38QeyhQbxW/g7zyNa9Y8qKL4PSodD/d8ro5c2h24N85/QYs6OOIP48UWActs0
         GKnw==
X-Gm-Message-State: AKwxytd7YlOSgUMEvnATtA8wmffOBf8dBd2NX9KwL/CZAJxSa+W7MQM3
        dcdr2US74Iy7o4FMTQFQ4KK2O0KKiQs=
X-Google-Smtp-Source: AH8x227RqW6xpf1VEp1eB6SKObaCMLiyBBSLDFNT4gBXaf1e6jEEvt3SYAq/Bg3Kl4Kji05v1LCiGA==
X-Received: by 10.98.15.27 with SMTP id x27mr38917890pfi.197.1517526647493;
        Thu, 01 Feb 2018 15:10:47 -0800 (PST)
Received: from [10.10.2.117] ([38.88.196.250])
        by smtp.gmail.com with ESMTPSA id i187sm691819pfc.99.2018.02.01.15.10.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 15:10:46 -0800 (PST)
From:   Keith Goldfarb <keith@blackthorn-media.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Git on Windows maps creation time onto changed time
Message-Id: <CCB76F06-DBA9-4342-8830-402F8AF9854A@blackthorn-media.com>
Date:   Thu, 1 Feb 2018 15:10:45 -0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.5.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git,

While tracking down a problem with a filesystem shared by Windows and =
Ubuntu, I came across the following code in compat/mingw.c =
(ming_fstat(), also in do_lstat()):

	if (GetFileInformationByHandle(fh, &fdata)) {
		buf->st_ino =3D 0;
		buf->st_gid =3D 0;
		buf->st_uid =3D 0;
		buf->st_nlink =3D 1;
		buf->st_mode =3D =
file_attr_to_st_mode(fdata.dwFileAttributes);
		buf->st_size =3D fdata.nFileSizeLow |
			(((off_t)fdata.nFileSizeHigh)<<32);
		buf->st_dev =3D buf->st_rdev =3D 0; /* not used by Git =
*/
		buf->st_atime =3D =
filetime_to_time_t(&(fdata.ftLastAccessTime));
		buf->st_mtime =3D =
filetime_to_time_t(&(fdata.ftLastWriteTime));
		buf->st_ctime =3D =
filetime_to_time_t(&(fdata.ftCreationTime));
		return 0;
	}

The assignment of buf->st_ctime doesn=E2=80=99t seem right to me. I =
understand there=E2=80=99s no good choice here, but I think a better =
choice would be to duplicate the definition used for st_mtime.

Background: When I do a git status on Windows and then later on Ubuntu =
(or the other order), it is extremely slow, as the entire tree is being =
traversed. I tracked it down to this difference in definition of c_time. =
Yes, I know about the core.trustctime variable, but my problem aside =
this seems like an unwise choice.

Thanks for listening,

K.

