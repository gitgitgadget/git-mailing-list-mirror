Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzU7PASk"
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5A1AB
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 03:07:55 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db981947bf9so1038707276.0
        for <git@vger.kernel.org>; Wed, 13 Dec 2023 03:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702465674; x=1703070474; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AkgApsKvkM4Xpyzzmn5QxDHQH4DgmwKWj1iJBwEzfAo=;
        b=GzU7PASkRl73lLXY4pIb3Ep83y+AeYmOTyVZUYXi8SuC2+N4VDaHak3ZXepvzF0dVp
         lot5aZQ/dDlKTtdsuVyKTnK0C7/+HpbL8UKaXPwPoS8HQCcR8eJnv0nZWLM2qkzieiAl
         SrBo3DVtOcDNjZhkBLdg5METcfJUOcRuEzE+y+8tPppYeDYZeE1pLsTlVDziIERpNDb/
         h4b2b838her9kfTAh+IpCWDIdkzU8IM8Lj52ua/HlI6YxXL8Kwh88KmbSZfVw4AFvN5v
         BBrLbmuwKAz/Tyms1Wk7sVRqZeeMDKJ/ZcfVaOlgwFKxISDFJBcWHL4E5WpXa+363Bjq
         tMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702465674; x=1703070474;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkgApsKvkM4Xpyzzmn5QxDHQH4DgmwKWj1iJBwEzfAo=;
        b=tWmDAhuesuw+HtJWxakzsWSM8OqayX42oec2zp8sKRTycDLLX9ANg52im7gDjx3BKb
         PfnDvJwhlyEdh5GGIilLyB9JhcNQ0pkB3DEph1xhEevb+ZYuIcxE1+B7IYCk1FSYO9FO
         qeJQeLc+XdvrwOVYXJTP6XwVDfgo7W+qI8bOD1UleRGZT1iwDYiKwsucNoFvNzPxY5Qy
         /u5AzWeEnUw37cYMU45nz6q+z/C9npk3rKEC8fXosuFsdBwJGOYfGKj+QjzHpUvPcQq+
         6/Bj1Xf1XLXUllXPFjWuFTgZCH8EKMSCxH88Tk9/uUUF5zeOpEOba2/7rMSLJ7OqtVih
         qSnA==
X-Gm-Message-State: AOJu0YxlB3TvzF+AoHM8Ss9LB5I03qnbqwnQ//NzvORGZRXKAiKNuGsJ
	K227QEylLMJKwDkHvBKyuG5aNAygGqNzIXp2NZn9Keu5SL5hog==
X-Google-Smtp-Source: AGHT+IHjqdmawDDF+Kpa0E2Pw6nR1SLyyWagXWFCAJ1zaJcVhoSSYLAHEUB7zOVZ0OG+PZrnmaePuzi+g7iSdx822SY=
X-Received: by 2002:a5b:7c8:0:b0:daf:f747:4a43 with SMTP id
 t8-20020a5b07c8000000b00daff7474a43mr7658054ybq.0.1702465674084; Wed, 13 Dec
 2023 03:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexey Murz Korepov <murznn@gmail.com>
Date: Wed, 13 Dec 2023 15:07:43 +0400
Message-ID: <CAL5pyKseyxEfLbgEkDHSqWQVLGkrrcZU=BzRx2zZOaCdQbMaoA@mail.gmail.com>
Subject: Allow adding files from git submodule to parent git repo if they are
 in .gitignore in the submodule
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Git submodules are pretty often used to "import" some external git
repository into your git repository, to not manage its files in your
git tree, that's good.

But very often we need to add some file to that submodule and manage
it in our local git repository, and this file is usually in .gitignore
in the submodule's git.

So, the example task is:

Copy a mysubmodule/config.example.yaml to mysubmodule/config.yaml
(which is in .gitignore in the mysubmodule), make local changes, and
store it in the local (parent) root git repo.

But the problem is that we can't add this mysubmodule/config.yaml file
to our root git repository, because receiving an error:
```
$ git add -f mysubmodule/config.yaml
fatal: Pathspec 'mysubmodule/config.yaml' is in submodule 'mysubmodule'
```
But I see no problems with doing this, if the file is in .gitignore of
the mysubmodule submodule.

So, let's discuss the approach of how we can allow this in git?

Or will be glad to hear and discuss alternatives and workarounds for this task.
