From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Tue, 08 Jan 2013 18:15:41 +0100
Message-ID: <50EC543D.5090100@web.de>
References: <20130106091642.GA10956@elie.Belkin> <1357465670-32766-1-git-send-email-pclouds@gmail.com> <20130106101948.GD10956@elie.Belkin> <20130108141650.GA18637@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:17:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tscnb-0008Ha-33
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab3AHRQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 12:16:55 -0500
Received: from mout.web.de ([212.227.17.11]:63264 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756668Ab3AHRQy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:16:54 -0500
Received: from [192.168.178.41] ([91.3.170.228]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LnS4I-1TLCh1422w-00hTLb; Tue, 08 Jan 2013 18:15:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130108141650.GA18637@lanh>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:eGL5vEKVkGT7UbFpYxMzcRAe/gY/bxi1xhRdRkaSKGj
 YHuAyWBGCfnOPAWNisbIpVDbaS8K8C58liQwd+YGj0uMi33qwR
 WTIMFDtryGoB6we7UFBmif17oUieB+UdhV9BnJv6QhVZr1HKGi
 +GgHjho/uW8NY302d8Yqw4FMl8e0Jz2lRVLmsojYFo+5JsnIT5
 EPeWmpD5zCe7qQDCb+LRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212977>

Am 08.01.2013 15:16, schrieb Duy Nguyen:
> On Sun, Jan 06, 2013 at 02:19:48AM -0800, Jonathan Nieder wrote:
>> 	Unfortunately we forgot to forbid the --bare
>> 	--separate-git-dir combination.  In practice, we know no one
>> 	could be using --bare with --separate-git-dir because it is
>> 	broken in the following way: <explanation here>.  So it is
>> 	safe to make good on our mistake and forbid the combination,
>> 	making the command easier to explain.
>>
>> I don't know what would go in the <explanation here> blank above,
>> though.  Is it possible that some people are relying on this option
>> combination?
> 
> I can't say it's broken in what way. Maybe it's easier to just support
> this case, it's not much work anyway. Jens, maybe squash this to your
> original patch?

I'd be fine with that, though my gut feeling is that this should
be a patch of its own (My patch handles the git dir, your's handles
a work tree issue). But I don't care much either way, what do others
think?

> -- 8< --
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 8d23a62..c8b09ad 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -375,6 +375,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
>  
>  static const char *junk_work_tree;
>  static const char *junk_git_dir;
> +static const char *junk_git_file;
>  static pid_t junk_pid;
>  
>  static void remove_junk(void)
> @@ -392,6 +393,8 @@ static void remove_junk(void)
>  		remove_dir_recursively(&sb, 0);
>  		strbuf_reset(&sb);
>  	}
> +	if (junk_git_file)
> +		unlink(junk_git_file);
>  }
>  
>  static void remove_junk_on_signal(int signo)
> @@ -772,6 +775,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	set_git_dir_init(git_dir, real_git_dir, 0);
>  	if (real_git_dir) {
> +		if (option_bare)
> +			junk_git_file = git_dir;
>  		git_dir = real_git_dir;
>  		junk_git_dir = real_git_dir;
>  	}
> diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
> index 4435693..231bc8a 100755
> --- a/t/t5600-clone-fail-cleanup.sh
> +++ b/t/t5600-clone-fail-cleanup.sh
> @@ -49,4 +49,14 @@ test_expect_success 'failed clone --separate-git-dir should not leave any direct
>  	rmdir foo/.git/objects.bak
>  '
>  
> +test_expect_success 'failed clone --separate-git-dir --bare should not leave any directories' '
> +	mkdir foo/.git/objects.bak/ &&
> +	mv foo/.git/objects/* foo/.git/objects.bak/ &&
> +	test_must_fail git clone --bare --separate-git-dir gitdir foo baaar &&
> +	test_must_fail test -e gitdir &&
> +	test_must_fail test -e baaar &&
> +	mv foo/.git/objects.bak/* foo/.git/objects/ &&
> +	rmdir foo/.git/objects.bak
> +'
> +
>  test_done
> -- 8< --
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
