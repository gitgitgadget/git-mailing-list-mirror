Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Nov 2023 13:47:10 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747DBC
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 13:47:10 -0800 (PST)
Received: from [192.168.178.189] ([79.246.86.112]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M42Ss-1r46bG0a1o-0000gt for <git@vger.kernel.org>; Fri, 17 Nov 2023 22:42:06
 +0100
Message-ID: <653b08fd-2df3-4a7a-8082-fdb809e87784@delpeuch.eu>
Date: Fri, 17 Nov 2023 22:42:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge-file: add --diff-algorithm option
Content-Language: en-US
To: git@vger.kernel.org
References: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3cYiVNe33j7KKIiF+1MJxP76+4lWkGRhC2OJZLdgHHJOfEs8mxb
 vOaW+Af4lfh+0taQc1funjKvGrTxUebtVSrZB9mDtvu+Y+RqwfobB+WmBjvefr7ptavOLWM
 c4U8qTzqlYD8X1IBWZrraZcW9kK2AmtGWu0z+SUEv0LOUYf7JKHuIGEFOze0eICcXoxH420
 wI9uZQhtznywQc1B2irzQ==
UI-OutboundReport: notjunk:1;M01:P0:uusJXCezlHQ=;M41kDyehZfwLOjKu3ksizSpuDf3
 gSSplC+Uhtz6Ker9sZTMMP2N/+VkhB/lnoYbTGXZLSwRb5IUXQcR/cjDk2SW3NO/U8it9i+wD
 3WQZP7ajWAjLqgeOOJLz6rAlH59R63XdNI1e1EHqJBT5RL/HDG8qQ+Ep47i5f6DqPCjc/f2oi
 M9D33GxwtoWuNAFZtXVlZkDsJ3QApgZUlojJNbAYHcozYkpYr5yl0IL3mQ5P90DN45q1m0+Rg
 feZxIx+602CWaYfhB8sWJsMqCFl9kZXe8Omf91flXJ9ardMuwJc5YVg71e8lRcdEdMoBSE/vA
 85lh1IBod3OG6F7fRB1agrVvzLdw7hMbU89l+KTzfH6q55BjG5pZHZt3QloAJZilvY1KAfySv
 iTBMl6a7WzrxXy5JSjtpBudXQP6hRqDP+Yny9n+c1gWs/MzGHk+diPzXKefnjsb45eVK0nJBv
 2jXhyaQV7q29DfZe7pHuCCqRe+zTFTEbH3jjUy4KoEJHOAHyDkmGJntc0UAlhc6zRK8r2frAA
 HiXfuSlH4jUkH+KRNQcFeG8/Hi/yPycGOURZyMfZsSHU6mFQ/wD5V5NeBFJaTEDFHR8paXxDe
 kLBAzLICSd4QQaRa+Fvf3oVCfMtN6Pl1fgwlZy4/CtYhhL4Ww7zLbHtpH5aTZADqZy723dqNL
 XZCJKofB4nVpqYvba4HdHiMIdJneLJphyTz3YE6oGABHm7pEOdaZS0VzzG37opsc/VChOQfAm
 84gqN60uARXMmTKHzH8c9B0qmWIaSaTqbI/4w8r30Q/WRxk/TxQXNGZ8phjZWEgOr5aUZjbpE
 PRBNPSmLOiy2Gkg5oHq0uS9GgsRZiZ76X5vwSHihVIzjOBUK8QVmXw5ptSeUizKFicB/mgs8w
 qAbniOmX1ClifVA==

Hi all,

Here a few more thoughts about this patch, to explain what brought me to 
needing that. If this need is misguided, perhaps you could redirect me 
to a better solution.

I am writing a custom merge driver for Java files. This merge driver 
internally calls git-merge-file and then solves the merge conflicts 
which only consist of import statements (there might be cases where it 
gets it wrong, but I can then use other tools to cleanup those import 
statements). When testing this, I noticed that the merge driver 
performed more poorly on other sorts of conflicts, compared to the 
standard "ort" merge strategy. This is because "ort" uses the 
"histogram" diff algorithm, which gives better results than the "myers" 
diff algorithm that merge-file uses.

Intuitively, if "histogram" is the default diff algorithm used by "git 
merge", then it would also make sense to have the same default for "git 
merge-file", but I assume that changing this default could be considered 
a bad breaking change. So I thought that making this diff algorithm 
configurable would be an acceptable move, hence my patch.

Of course, the diffing could be configured in other ways, for instance 
with its handling of whitespace or EOL (similarly to what the "git-diff" 
command offers). I think those options would definitely be worth 
exposing in merge-file as well. If you think this makes sense, then I 
would be happy to work on a new version of this patch which would 
attempt to include all the relevant options. I could also try to add the 
corresponding tests.

But perhaps my need is misguided? Could it be that I should not be 
writing a custom merge driver, but instead use another extension point 
to only process the conflicting hunks after execution of the existing 
merge driver? I couldn't find such an extension point, but it can well 
be that I missed it.

Thank you,

Antonin

