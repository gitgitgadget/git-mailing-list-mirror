From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Sat, 21 Mar 2015 22:00:58 +0800
Message-ID: <CACRoPnQ4iJMn7+eujOXUN6dks2HMQYRw+nYfM1QvOD+k7BCtEQ@mail.gmail.com>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
	<4cae16222697894b19856d12b062f68e@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 21 15:01:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZJxe-0005wI-Lq
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 15:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbbCUOBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 10:01:02 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33294 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbbCUOBA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2015 10:01:00 -0400
Received: by lbbrr9 with SMTP id rr9so28129809lbb.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZyIRCTXaUFHgj7YUt+PhI+9ZAYepZDiUDruCIvj2bp4=;
        b=jJp7V/btBECnH7OfjUIBGijq4dNQhLw/JXZhm7WIGp3GL8kOI80Q/qm+Ls/skgxKC+
         Q2sqzpH7/rqoSpR3DvUcNJihYulAWPCPiCMquRhGbOqsQiamI/Af16zStqW+vZFZ8x9O
         ssCi2tvWlI7sqatQBuwQLlsNKtNfVMX1TIyPeIkXKYZHKGBYzAoR+lWiZlM716rCPaOS
         hsDUqhUvR4YPjpjbvAqPaJzELSCQp5MClYYkeCGmYBFv78UziUDXxJgN5pYiQjBM3CKF
         Q3uH4FmAicb5ErgHZPhc8oQmG7abMzQiZEk6t1m+AxA6yyQEqVNGn7D5eXJr9OV6bpwE
         tikg==
X-Received: by 10.112.44.132 with SMTP id e4mr76666556lbm.66.1426946459057;
 Sat, 21 Mar 2015 07:00:59 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Sat, 21 Mar 2015 07:00:58 -0700 (PDT)
In-Reply-To: <4cae16222697894b19856d12b062f68e@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266023>

Hi,

Thanks for your suggestions, I agree with most of them :).

On Wed, Mar 18, 2015 at 5:00 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>> +static int parse_opt_rebase(const struct option *opt, const char
>> *arg, int unset)
>> +{
>> +     if (arg)
>> +             *(int *)opt->value = parse_rebase(arg);
>> +     else
>> +             *(int *)opt->value = unset ? REBASE_FALSE : REBASE_TRUE;
>> +     return (*(int *)opt->value) >= 0 ? 0 : -1;
>> +}
>
> In this function (and also in other places below), there is this pattern that a `struct option` pointer is passed to the function, but then only `*(int *)opt->value` is written to. Therefore, I would suggest to change the signature of the function and pass `(int *)opt->value` as function parameter.

It's used as a callback for the argument parser though, so the
callback signature is required.

>
>> +static int has_unstaged_changes(void)
>
> Yeah, this function, as well as the ones below it, look as if they are so common that they *should* be already somewhere in libgit.a. But I did not find them, either...
>
> Of course it *would* be nice to identify places where essentially the same code is needed, and refactor accordingly. But I think that is outside the scope of this project.

Actually, I think that identifying the places where code can be
trivially shared (without requiring major refactoring) should be part
of the project, otherwise lots of code may be duplicated and cause
code bloat. The obvious one would be fork_point() in this patch, which
is copied from the merge-base builtin and not accessible because it
has static linkage. The project should, at the very least, allow the
function to be shared between git-pull and git-merge-base, as well as
to modify the function so that it can fail without die()-ing.

Regards,
Paul
