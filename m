Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9B2C69F
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+CO94be"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e2ce4fb22so262724e87.1
        for <git@vger.kernel.org>; Sat, 16 Dec 2023 05:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702734332; x=1703339132; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tlOOSqdh8HfNjZD97fPLAW7o/274N4c9ePeL7bca2fA=;
        b=e+CO94bempklK4E6f1HW+6x3wjYeIDFVjMRX7+faFPvl5BkUPWqyF5wYmzTyIZdMMG
         YVG+VwVOqNlQ4opJCgtvCQPxY2IJF+Dn7/ZEjGCwqCeQd615O6sqs+exhZfvm1nmtZCz
         7NJ6j3xfLsvRRxiOSDwF60eQ3vyG1pd+KFh4NSmWFii5o2i2qWoMribdOFNxIX4gV6LM
         u2YEoBURA0P61aYt5fXmY7WeB+GBewYE08qR8wq89QlnL8EEmSUhfYmhroaBTQI1kV6O
         Nk2D3eoP5pZeaAYm+g0pRCMF4g0ABC4p5VKQt3UuB9f3QCnFoum+Z2o/Lw+pVos9huHE
         wrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702734332; x=1703339132;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlOOSqdh8HfNjZD97fPLAW7o/274N4c9ePeL7bca2fA=;
        b=HuYR6jwQcpQJv0A64f92Bdba2mVnDmTsPVA+pgVQIi4p1sm5iwFW5K0kbX52z+qp6r
         RfkiDMUXXMzEgx7vCptdbZwJlxX8cWKXy7dpUyL7il/NVmdr0K1ssWsGFjvK275k5Sso
         wyJmGU0yqYtMfCI3ppWvRh0l6W6nujOp+R1Phq13HI3HHAZjR/4+1CNn7DOc4SPD5hyq
         0341Vo07jWtaIY1UJUlVxCkfLQ2i2kTe8JyUNsj1+QkSEP/7VGU5+NlHCuD8yJ/YfTEh
         TRE39PN+SQmKU8+ukc7sNXgz/JaKZCEtEQ2aNYkVnTb8QSiSuaChHUny9JxO7vCOdOFz
         Mf1Q==
X-Gm-Message-State: AOJu0YxzwF+IU2PWUE7ml4xEvYfl7TLK5RJH8+SMMaB/NtZeqxUnZZYZ
	PxthF2uoa0P5CFsjcBJPwAf+G4yiwVbASss7G19L7eVboqs=
X-Google-Smtp-Source: AGHT+IGV6ZEgJcRJyP3xdPe1j8NErI5w33TSTu6Ki/kzoDSiSgfyiwdeYrKAUtdRSQSOBxQiaCm3RZFb48nXLKB5Qp0=
X-Received: by 2002:a05:6512:203:b0:50e:1b2e:5888 with SMTP id
 a3-20020a056512020300b0050e1b2e5888mr1920036lfo.42.1702734331467; Sat, 16 Dec
 2023 05:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vinayak Dev <vinayakdev.sci@gmail.com>
Date: Sat, 16 Dec 2023 19:15:20 +0530
Message-ID: <CADE8NaqwR8JA809k9AN_fm8EEcE5-cXgD0PnXf3hatxcYimU1g@mail.gmail.com>
Subject: MyFirstContribution.txt leaks memory
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone!
I was going through the MyFirstContribution tutorial and implemented
its code as an exercise to warm up my git skills.
However, when I pushed the code to my fork on GitHub, I noticed that
it fails the linux-leaks test.
So I fired up the leaks checker that MacOS provides and got a number
of leaks in the tutorial code.
One was that the strbuf commitline was not released, so I was able to
fix that trivially.

However, the stack trace for the second leak shows that the memory
leaks  when git_config() is called on the wt_status struct, which in turn
calls the git_default_config() function. As it must go through my
.gitconfig, I noticed that when it checks for "core.editor", it calls
git_config_string(), where the string is duplicated into the
editor_program variable.

This is precisely where the leak seems to be, as pointed out by the
stack of function calls. I thought that maybe freeing dest as in
free((void *)*dest) in git_config_string() before calling xstrdup()
might free up the leakage (this has been done in a number of places in
the code-base).

While this does free up the leakage, I am getting a number of failures in
the test suite(some of which are occurring even without the changes),
particularly related to setting up bare repositories.

Also, as only the tutorial code's binary(./bin-wrappers/git psuh) that I
implemented leaks memory, I suspect that it is my fault somewhere.

Could anyone point out what is the correct way to free up memory in this case?
Or would the situation warrant adding the call to free() in git_config_string()?

Thanks a lot!
Vinayak
