Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06DF720958
	for <e@80x24.org>; Tue, 28 Mar 2017 10:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932070AbdC1Kr2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 06:47:28 -0400
Received: from mx1.riseup.net ([198.252.153.129]:40603 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755184AbdC1Kr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 06:47:26 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 53F6B1A090A
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490698021; bh=RTY0GbkB7SDvP0wWGVPCr4ergVnoG167qkJFRsD1tC8=;
        h=Date:From:To:Subject:From;
        b=jRdh4riABBZjRXYjARxhoqsqhe3bl+qE+TWSN8oWZ4yiCw7s+Tia7FbCFvJOWWAia
         1tsDPTwGhdgz3I0b9PyvuF2JtQNJhfLbOFi5JnQJdbPuc9WBrl63WGeG863SHkpGUK
         +hALw2o6H58b2hCjqnCfeFN6GRb5G71nLCrwFkRY=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id A2B311C04A4
Date:   Tue, 28 Mar 2017 18:46:52 +0800
From:   Pickfire <pickfire@riseup.net>
To:     git <git@vger.kernel.org>
Subject: Microproject | Add more builtin patterns for userdiff
Message-ID: <20170328104652.XsS8a6ysu%pickfire@riseup.net>
Mail-Followup-To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While I was working buildins shell patterns for user diffs. I noticed that
the tests t4034 passes but I can reproduce it manually with:

    mkdir cpp/ && cd cpp/ && git init

    cat > pre <<EOF
    Foo():x(0&&1){}
    cout<<"Hello World!\n"<<endl;
    1 -1e10 0xabcdef 'x'
    [a] a->b a.b
    !a ~a a++ a-- a*b a&b
    a*b a/b a%b
    a+b a-b
    a<<b a>>b
    a<b a<=b a>b a>=b
    a==b a!=b
    a&b
    a^b
    a|b
    a&&b
    a||b
    a?b:z
    a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
    a,y
    a::b
    EOF

    cat > post <<EOF
    Foo() : x(0&42) { bar(x); }
    cout<<"Hello World?\n"<<endl;
    (1) (-1e10) (0xabcdef) 'y'
    [x] x->y x.y
    !x ~x x++ x-- x*y x&y
    x*y x/y x%y
    x+y x-y
    x<<y x>>y
    x<y x<=y x>y x>=y
    x==y x!=y
    x&y
    x^y
    x|y
    x&&y
    x||y
    x?y:z
    x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
    x,y
    x::y
    EOF

    echo '* diff="cpp"' > .gitmodules
    git diff --no-index --color-words pre post > output

Surprisingly, it shows (which is very different from the expected output):

^[[1mdiff --git a/pre b/post^[[m
^[[1mindex 23d5c8a..7e8c026 100644^[[m
^[[1m--- a/pre^[[m
^[[1m+++ b/post^[[m
^[[36m@@ -1,19 +1,19 @@^[[m
^[[31mFoo():x(0&&1){}^[[m^[[32mFoo() : x(0&42) { bar(x); }^[[m
cout<<"Hello ^[[31mWorld!\n"<<endl;^[[m
^[[31m1 -1e10 0xabcdef 'x'^[[m
^[[31m[a] a->b a.b^[[m
^[[31m!a ~a a++ a-- a*b a&b^[[m
^[[31ma*b a/b a%b^[[m
^[[31ma+b a-b^[[m
^[[31ma<<b a>>b^[[m
^[[31ma<b a<=b a>b a>=b^[[m
^[[31ma==b a!=b^[[m
^[[31ma&b^[[m
^[[31ma^b^[[m
^[[31ma|b^[[m
^[[31ma&&b^[[m
^[[31ma||b^[[m
^[[31ma?b:z^[[m
^[[31ma=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b^[[m
^[[31ma,y^[[m
^[[31ma::b^[[m^[[32mWorld?\n"<<endl;^[[m
^[[32m(1) (-1e10) (0xabcdef) 'y'^[[m
^[[32m[x] x->y x.y^[[m
^[[32m!x ~x x++ x-- x*y x&y^[[m
^[[32mx*y x/y x%y^[[m
^[[32mx+y x-y^[[m
^[[32mx<<y x>>y^[[m
^[[32mx<y x<=y x>y x>=y^[[m
^[[32mx==y x!=y^[[m
^[[32mx&y^[[m
^[[32mx^y^[[m
^[[32mx|y^[[m
^[[32mx&&y^[[m
^[[32mx||y^[[m
^[[32mx?y:z^[[m
^[[32mx=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y^[[m
^[[32mx,y^[[m
^[[32mx::y^[[m

Instead of:

<BOLD>diff --git a/pre b/post<RESET>
<BOLD>index 23d5c8a..7e8c026 100644<RESET>
<BOLD>--- a/pre<RESET>
<BOLD>+++ b/post<RESET>
<CYAN>@@ -1,19 +1,19 @@<RESET>
Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <GREEN>bar(x);<RESET> }
cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>&<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>^<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>|<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>&&<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>||<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
<RED>a<RESET><GREEN>y<RESET>
<GREEN>x<RESET>,y
<RED>a<RESET><GREEN>x<RESET>::<RED>b<RESET><GREEN>y<RESET>

That's does not just happens to cpp builtins, it happens to bibtex as well.
Is it that I had missed some configuration since I have tested this on a
few machines?

I have a workaround for that, which is to run log with --color-words=<regex>
with regex from the userdiff.c, does it automatically use the builtins diff?
