Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnbVFimA"
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D554E135
	for <git@vger.kernel.org>; Tue,  5 Dec 2023 23:16:23 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4079472276.2
        for <git@vger.kernel.org>; Tue, 05 Dec 2023 23:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846983; x=1702451783; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HF2eJmbmYybjtuqdqmpakqnvm4BSZADZSZKx90OgiuI=;
        b=mnbVFimAHq9r4p+OUulQZGvjy/y0raHbwXnOqMMTVqqRqD2y0yzWEH8IL0reg6f+V7
         BmPqfnBdCLD3WG/hv68j/fouTXEFoJY5wUqi4Ggp9QzV9fSNR2+AmkDFsFwifCywkZBM
         4Lg12Mgo7gMZzjuMwYaglQzc2CN8NmzmegErYrWxMOCris8RtmI/ERbr/TA6LsF34Ypd
         uwG6q8FmFgbdRTwAdB3zMHq3cfhDSL3dqExd/V/+kWIe9twNWynuRByx8ItozWm5HEMn
         4rBe/d5lnG/Wjr5QChpKKraRmtiac9LE6Dfeoq9zgbj/Q3X8RkAAIzoTq20scfhZW8rE
         jJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846983; x=1702451783;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HF2eJmbmYybjtuqdqmpakqnvm4BSZADZSZKx90OgiuI=;
        b=D5+4yxJqZY6YqBmliOedztoSW0VACQgMNa8BdAdzItQxoJWQCbc15Z28bYSr3hT/4p
         GLLenhMZfdi/nn1XqTJuSXwZidooDLvw4pKuTOWiWcLXzZBJc7Z2+ufKOGpZJ/8embF1
         SPo7w9Mb1f9ZVgxPjm/yBPDgaXvw7LCXx+Q7Ra1AoJcb2Gm54kzNj9pyEKKy/DFCf6Gu
         qqtPUNO7Lmy2fwK3mfkOoFdg0BSZAdTDUlsedyYDXjoJKFcvUhTmqr6wp/+aTDaS5GNC
         B7b98nUFzNyDYg4uzYtI57SUZYeHtaIv3rs4Loivo2Pbi0ReDKlCxNMotLLpDg/xUy5+
         pwkg==
X-Gm-Message-State: AOJu0YyWF5uQSqup4iwomWs1VBMbAMNNc9qYSB/COfMywsTnsggZZwjo
	09kUvID+8oFvXU2EqgqJYjzBkeuHqcxVclNkgXrrsim0Zy4=
X-Google-Smtp-Source: AGHT+IFbTKS0KCfMo++uzXKBpReAJxYDfcBD1ZQLd7+3ZH3S8zmvAJqiAfBq+iB4dmCRunuTGiJsPI1pFUxTZGJL64s=
X-Received: by 2002:a25:3211:0:b0:db7:dacf:4d86 with SMTP id
 y17-20020a253211000000b00db7dacf4d86mr144631yby.130.1701846982900; Tue, 05
 Dec 2023 23:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Etter <simon0etter@gmail.com>
Date: Wed, 6 Dec 2023 15:16:12 +0800
Message-ID: <CAFy4k4JpyqWCDH48YZJ6wc6nhtUq7J43ZHwg8-LDTQfDMsMqSg@mail.gmail.com>
Subject: git checkout --recurse-submodules deletes local modifications
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there!

It seems git checkout --recurse-submodules doesn't live up to its
documentation. According to the docs:

> If local modifications in a submodule would be overwritten the checkout will fail unless -f is used.

Here's an MWE where git checkout --recurse-submodules does overwrite
local modifications:

```
# Prepare repo
rm -rf /tmp/test
mkdir /tmp/test
cd /tmp/test
git init
git submodule add git@github.com:octocat/Hello-World.git
git commit -m "Add submodule"
git checkout -b other
cd Hello-World
git checkout 762941318ee16e59dabbacb1b4049eec22f0d303
cd ..
git add Hello-World
git commit -m "Change submodule commit"

# Add local modification
echo boo! > Hello-World/README

# Switch branches. This completes without error, and deletes the
change introduced in the previous line.
git checkout main --recurse-submodules
```

I believe part of the problem is that
762941318ee16e59dabbacb1b4049eec22f0d303 and
7fd1a60b01f91b314f59955a4e4d4e80d8edf11d (the Hello-World master
commit) are the same; the last line does report an error if I make
`other` point at 553c2077f0edc3d5dc5d17262f6aa498e69d6f8e instead of
the above commit. However, I don't think this changes the fact that
the above MWE makes git checkout --recurse-submodules look pretty
dangerous.

I'd love to hear if

1) the above is intended behavior,
2) I'm doing something wrong, or
3) this is a bug.

Best regards, and thanks for all your hard work,
Simon
