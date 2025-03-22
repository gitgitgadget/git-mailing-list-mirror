Received: from forward401b.mail.yandex.net (forward401b.mail.yandex.net [178.154.239.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DED18A6C1
	for <git@vger.kernel.org>; Sat, 22 Mar 2025 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742685825; cv=none; b=kcOha5cpLG/IabMxciVkD250wyOvzwXUUfZuR/IKa1d/sRUSxzKLqLRpccdk0NXbcPXY7pKDczFrhcEPCArOk2zSG1zGUzeVrMObEpVqLCSpOz0UytgbOBg5EyTDNcdCAJEHtqBakgPrd22aMq0umgJHZgpycUayjBTei9EKxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742685825; c=relaxed/simple;
	bh=NrsIFE0X4NQNjW6ObN2+tyIDQmxoKmmSIBsB89vIXg8=;
	h=Date:From:Message-ID:To:Subject:MIME-Version:Content-Type; b=q3LXUk6YRVPfsSmcZ8PYio0QPYMOlW7CKB3JwHXEs4W5pxtqx76dcqENUbnjQgFH/0AdWvaSRfM72B/+SYtIdapSLh6ibJdjyzSTfy3OjwHHsSj3x/hW5ARNrb3jKk1W3NM10CIB2ZSzlcvuxgS2Zwwyy63oQq5i8PqoQqh4DR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LhCr0psp; arc=none smtp.client-ip=178.154.239.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LhCr0psp"
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:36c1:0:640:ebf1:0])
	by forward401b.mail.yandex.net (Yandex) with ESMTPS id 643F2632CC
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 02:16:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nGWehVcLieA0-Q27vkWk2;
	Sun, 23 Mar 2025 02:16:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1742685412; bh=O275tAwt04vMrl/4i+IzkkJDOLYR48ZaxYG3FSpoKpM=;
	h=Subject:To:Message-ID:From:Date;
	b=LhCr0pspXd41Gl6z0BDY3zuFWpNSNDJ/yozFRvGN/VbA5L+Esp3XmxLAIXYTYloGr
	 iPp3nEgoqBSAKJVT0JoSTAFExru3mMEgV3yPMol8JjjIY3J9m4teuQ0TpL+QJasXOt
	 Up6kK4smerAQCfBHMiBmMOhIDZb0ThQ+ODTAYZFA=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Date: Sat, 22 Mar 2025 19:16:49 -0400
From: Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1145598425.20250322191649@yandex.ru>
To: Git Mailing List <git@vger.kernel.org>
Subject: Why merge conflict block is located at the wrong place?
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Git,

I got this merge conflict:
```
sub alter_field {
  my ($from_field, $to_field, $options) = @_;

  die "Can't alter field in another table"
      if ($from_field->table->name ne $to_field->table->name);

<<<<<<< HEAD
  my $generator = _generator($options);
  my @out;
||||||| parent of 1bfbcdad (Introduce and use Postgres in-database schemas)
    die "Can't alter field in another table"
        if($from_field->table->name ne $to_field->table->name);
=======
    die "Can't alter field in another table"
        if($from_field->table->qualified_name ne $to_field->table->qualified_name);
>>>>>>> 1bfbcdad (Introduce and use Postgres in-database schemas)

  # drop geometry column and constraints
  push @out, drop_geometry_column($from_field, $options), drop_geometry_constraints($from_field, $options),
      if is_geometry($from_field);
```

But I expect it to be like this:
```
sub alter_field {
  my ($from_field, $to_field, $options) = @_;

<<<<<<< HEAD
  die "Can't alter field in another table"
      if ($from_field->table->name ne $to_field->table->name);
||||||| parent of 1bfbcdad (Introduce and use Postgres in-database schemas)
    die "Can't alter field in another table"
        if($from_field->table->name ne $to_field->table->name);
=======
    die "Can't alter field in another table"
        if($from_field->table->qualified_name ne $to_field->table->qualified_name);
>>>>>>> 1bfbcdad (Introduce and use Postgres in-database schemas)

  my $generator = _generator($options);
  my @out;

    # drop geometry column and constraints
  push @out, drop_geometry_column($from_field, $options), drop_geometry_constraints($from_field, $options),
      if is_geometry($from_field);
```

Why merge conflict block is located at the wrong place?

git version 2.49.0

-- 
Best regards,
Eugen Konkov

