Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E634A04
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgqeVxzD"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6da9c834646so3035045b3a.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 16:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704847440; x=1705452240; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/pzgWusZz1u2m7/+omsW9BM8dKQHJASkkUZvzrgG1hs=;
        b=BgqeVxzD9o7ooPK6FebVSpttxQHJO8bpS7qFrKXddnynPON3/Y72W/xsOx4oT/tWIb
         AyBwuMPXmGG8y1dA5lJLI9e+HFMnVgQtDQ6hfeqEDmaIMGpvfNDgHYJecksm2Dez1DbH
         cv7X199lg7hnZ5fM/h4Y+LIU+jW7Hb90Pcr5BsUGJAlQtXfn8HyMeLUb4jazo6v+R2kE
         +2z6CGqQtEtDxn181y3bnrk1Ugb06RejefEJD6egHo06iexaigHiY5VIRPbKb27U2G7H
         uTTxS7MKowcWtU4y8NkLp8CIhoSHm3ZRAaCDQGyLdNT68MCERL8/dHyVlSpDbZNnDN6u
         ghMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704847440; x=1705452240;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pzgWusZz1u2m7/+omsW9BM8dKQHJASkkUZvzrgG1hs=;
        b=iNbx41pfVosle1Rw9q7aoeChHPOmiq8UPofoN2cgi3QsZW2yNdaCl6XiDGk39PMCRX
         vTbXrO29mTY/ios6ocm74p8wNGnSCb2gtlvxcWcBmKIVK3KtX5el0/QWsvKyzRHiCWoK
         /22Ik+UUtQBXXpvum0dtq+xWsL5+CIIZUg+WBwDh3le2zk6KNmkenZQ/la+n1VxxCRj8
         u4igDGC7KSvs805q4kG5Rtn5SJZfTO0UolnEl7elI4kbWgR6YpyqbzKZ1R3w3Wtq77mW
         sTZiad9GcPdFbLt87dgW1jmT3/ZjVPws75DD/0/cUyOtUSFOvoioxtSAlLefP57zU6lP
         12Xg==
X-Gm-Message-State: AOJu0YxydVv07e2a6zRAAJUn8siLYUAKxZibOINBImtYCQb/TmmyRPoF
	jSe/yB4WOrARDB6pnnruWGhZOLZ+GYcZlhEBlAxzTfE3I40=
X-Google-Smtp-Source: AGHT+IFhVXvGZUlgAu0o83x6Z/XvdkSPIwiGuI/FnAcsSYcZFT6opLfrAdUQy5bEeDvdNqpZfDDEScy6vCrb0Iofzew=
X-Received: by 2002:a05:6a20:9183:b0:19a:248c:bb68 with SMTP id
 v3-20020a056a20918300b0019a248cbb68mr28756pzd.57.1704847440283; Tue, 09 Jan
 2024 16:44:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
Date: Tue, 9 Jan 2024 21:43:33 -0300
Message-ID: <CACjc_5pdijCZrrXQWHswsxYrGUzZ7pZq+nj3SzY1z+Xxop64Ww@mail.gmail.com>
Subject: Problem in gitweb.cgi
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have recently run into a problem with gitweb that was triggered by
my distribution, OpenSUSE Tumbleweed. Due to a misconfiguration of the
application AppArmour, "git instaweb" was having problems in accessing
the configuration file "/etc/gitweb-common.conf". That was half of the
problem and has been reported downstream here:
https://bugzilla.suse.com/show_bug.cgi?id=1218664

The other half of the problem is in gitweb.cgi itself. There is a
logic to select which configuration file is going to be used. That
logic is ok, although a bit unclear from the documentation. Reading
the code I understood that $GITWEB_CONFIG_COMMON (usually
/etc/gitweb-common.conf) should always be read if it exists, and
$GITWEB_CONFIG_SYSTEM (usually /etc/gitweb.conf) will never be read if
$GITWEB_CONFIG has been read before.

The problem is that $GITWEB_CONFIG_COMMON was never read, even though
the code that reads it was being called before the code that reads the
other two files. As I said before, the problem was caused by a lack of
permission in AppArmour, but gitweb should have been able to catch the
error. By not signaling it properly, users get lost because the
problem is a little tricky to debug.

After some "printf" debugging, I converged to this routine, line 728
of gitweb.cgi:

# read and parse gitweb config file given by its parameter.
# returns true on success, false on recoverable error, allowing
# to chain this subroutine, using first file that exists.
# dies on errors during parsing config file, as it is unrecoverable.
sub read_config_file {
        my $filename = shift;
        return unless defined $filename;
        # die if there are errors parsing config file
        if (-e $filename) {
                do $filename;
                die $@ if $@;
                return 1;
        }
        return;
}

Perl uses two different variables to manage errors from a "do". One is
"$@", which is set in this case when do is unable to compile the file.
The other is $!, which is set in case "do" cannot read the file. By
printing the value of $! I found out that it was set to "Permission
denied". Since the script does not currently test for $!, the error
goes unnoticed.

I suppose a proper fix would be to put a line before the test for $@,
like "die $! if $!".

For the curious, I have a report explaining the full problem here, but
the part relevant to gitweb is in this e-mail:
https://stackoverflow.com/questions/77789216/problem-with-git-instaweb-on-opensuse-tumbleweed-etc-gitweb-common-conf-is-n

Best regards,
Marcelo.
